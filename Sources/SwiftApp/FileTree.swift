import Foundation

class FileTree {
    
    private let fileManager = FileManager.default
    private let url: URL
    static let documentsDir: URL = {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return URL(string: documentsDirectory)!
    }()
    
    init(_ url: URL) {
        self.url = url
    }
    
    convenience init() {
        self.init(Self.documentsDir)
    }
    
    convenience init(_ path: String) {
        self.init(URL(fileURLWithPath: path))
    }
    
    func tree(getInfo: @escaping (URL, Bool) -> String) -> String {
        url.absoluteString + "\n" + self.crawl(url: url, prefix: "", getInfo: getInfo)
    }
    
    var tree: String {
        url.absoluteString + "\n" + self.crawl(url: url, prefix: "")
    }
    
    private func crawl(url: URL, prefix: String, getInfo: ((URL, Bool) -> String)? = nil) -> String {
        let files = (try? self.fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: [])) ?? []
        var output = ""
        files.enumerated().forEach { index, fileUrl in
            let isDir = (try? fileUrl.resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory ?? false
            let isLast = index == files.count - 1
            let graphic = isLast ? "└──" : "├──"
            let filename = fileUrl.pathComponents.last ?? "nil"
            let fileUrl = url.appendingPathComponent(filename)
            output.append("\(prefix)\(graphic) \(filename) \(getInfo?(fileUrl, isDir) ?? "")\n")
            if isDir {
                let newPrefix = prefix + (isLast ? "    " : "│   ")
                output.append(self.crawl(url: fileUrl, prefix: newPrefix, getInfo: getInfo))
            }
        }
        return output
    }
}
