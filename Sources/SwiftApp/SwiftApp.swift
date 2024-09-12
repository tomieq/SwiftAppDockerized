import Foundation

@main
public struct SwiftApp {

    public static func main() {
        let workingDir = FileManager.default.currentDirectoryPath
        print("workingDir: \(workingDir)")
        print(FileTree(workingDir).tree)
        let shell = Shell()
        print(shell.exec("file \(workingDir)/App"))
        print(shell.exec("ldd \(workingDir)/App"))
        
        if let url = ProcessInfo.processInfo.environment["URL"] {
            print("Enviromental variale URL: \(url)")
        } else {
            print("Missing enviromental variale URL")
        }
    }
}
