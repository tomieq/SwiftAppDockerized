import Foundation

@main
public struct SwiftApp {

    public static func main() {
        let workingDir = FileManager.default.currentDirectoryPath
        print("workingDir: \(workingDir)")
        print(FileTree(workingDir).tree)
    }
}
