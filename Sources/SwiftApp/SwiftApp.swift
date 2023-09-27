import Foundation

@main
public struct SwiftApp {

    public static func main() {
        let workingDir = FileManager.default.currentDirectoryPath
        print("workingDir: \(workingDir)")
        print(FileTree(workingDir).tree)
        let shell = Shell()
        print(shell.exec("file \(workingDir)/SwiftApp"))
        print(shell.exec("ldd \(workingDir)/SwiftApp"))
    }
}
