import Standard_Library_Extensions

extension ISO_639 {

    public enum Error: Swift.Error, Sendable, Equatable {

        case invalidCodeLength(Int)

        case invalidCharacters(String)

        case invalidAlpha2Code(String)

        case invalidAlpha3Code(String)
    }
}
