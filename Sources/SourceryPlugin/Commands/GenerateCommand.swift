import ArgumentParser
import Foundation
import PathKit
import ProjectAutomation

struct GenerateCommand: ParsableCommand {
    func run() throws {
        let graph = try Tuist.graph()
        let mintfile = Path.current + Path("Mintfile")
        try graph.projects
            .values
            .filter { !$0.isExternal }
            .map { Path("\($0.path)") }

            .forEach { path in
                try path.chdir {
                    if (try? (Path.current + Path("sourcery.yml")).read()) != nil {
                        let command = "mint run --mintfile \(mintfile) sourcery --config sourcery.yml"
                        try safeShell(command)
                    } else {}
                }
            }
    }

    @discardableResult // Add to suppress warnings when you don't want/need a result
    func safeShell(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()

        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh") // <--updated
        task.standardInput = nil

        try task.run() // <--updated

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        return output
    }
}
