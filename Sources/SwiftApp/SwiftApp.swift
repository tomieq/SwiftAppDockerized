@main
public struct SwiftApp {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(SwiftApp().text)
    }
}
