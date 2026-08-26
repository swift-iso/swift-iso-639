import ASCII
import Standard_Library_Extensions

extension ISO_639 {

    public struct LanguageCode: Sendable, Equatable, Hashable {

        public let alpha2: Alpha2?

        public let alpha3: Alpha3

        public init(alpha2: Alpha2?, alpha3: Alpha3) {
            self.alpha2 = alpha2
            self.alpha3 = alpha3
        }

        public init(alpha3: Alpha3) {
            self.alpha2 = nil
            self.alpha3 = alpha3
        }
    }
}

extension ISO_639.LanguageCode {

    public init(_ code: some StringProtocol) throws(ISO_639.Error) {
        let normalized = code.lowercased()

        switch normalized.count {
        case 2:

            do throws(ISO_639.Alpha2.Error) {
                let alpha2 = try ISO_639.Alpha2(normalized)

                let alpha3 = ISO_639.Alpha3(alpha2)
                self.init(alpha2: alpha2, alpha3: alpha3)
            } catch {
                switch error {
                case .invalidCodeLength(let n): throw .invalidCodeLength(n)
                case .invalidCharacters(let s): throw .invalidCharacters(s)
                case .invalidAlpha2Code(let s): throw .invalidAlpha2Code(s)
                }
            }

        case 3:

            do throws(ISO_639.Alpha3.Error) {
                let alpha3 = try ISO_639.Alpha3(normalized)

                let alpha2 = ISO_639.Alpha2(alpha3)
                self.init(alpha2: alpha2, alpha3: alpha3)
            } catch {
                switch error {
                case .invalidCodeLength(let n): throw .invalidCodeLength(n)
                case .invalidCharacters(let s): throw .invalidCharacters(s)
                case .invalidAlpha3Code(let s): throw .invalidAlpha3Code(s)
                }
            }

        default:
            throw .invalidCodeLength(normalized.count)
        }
    }
}

extension ISO_639.LanguageCode: CustomStringConvertible {

    public var description: String {
        alpha2?.value ?? alpha3.value
    }
}

extension ISO_639.LanguageCode: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }
}
