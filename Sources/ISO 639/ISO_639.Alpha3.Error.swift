extension ISO_639.Alpha3 {
    public enum Error: Swift.Error, Sendable, Equatable {

        case invalidCodeLength(Int)

        case invalidCharacters(String)

        case invalidAlpha3Code(String)
    }
}
