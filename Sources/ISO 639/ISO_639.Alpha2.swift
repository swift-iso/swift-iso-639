import ASCII_Primitives
import Standard_Library_Extensions

extension ISO_639 {

    public struct Alpha2: Sendable, Equatable, Hashable {

        public let value: String

        public init(_ value: some StringProtocol) throws(Error) {
            let normalized = value.lowercased()

            guard normalized.count == 2 else {
                throw Alpha2.Error.invalidCodeLength(normalized.count)
            }

            guard normalized.allSatisfy({ $0.ascii.isLetter }) else {
                throw Alpha2.Error.invalidCharacters(normalized)
            }

            guard Self.validCodes.contains(normalized) else {
                throw Alpha2.Error.invalidAlpha2Code(normalized)
            }

            self.value = normalized
        }
    }
}

extension ISO_639.Alpha2 {

    internal init(unchecked value: String) {
        self.value = value
    }

    internal static let validCodes: Set<String> = {
        Set(allCases.map { $0.value })
    }()
}

extension ISO_639.Alpha2: CustomStringConvertible {
    public var description: String { value }
}

extension ISO_639.Alpha2: Codable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }
}

extension ISO_639.Alpha2 {

    public init?(_ alpha3: ISO_639.Alpha3) {

        guard let alpha2 = ISO_639.alpha3ToAlpha2[alpha3] else {
            return nil
        }
        self = alpha2
    }
}
