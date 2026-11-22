extension ISO.`639`.Alpha2 {
    public enum Error: Swift::Error, Sendable, Equatable {

        case invalidCodeLength(Int)

        case invalidCharacters(String)

        case invalidAlpha2Code(String)
    }
}
