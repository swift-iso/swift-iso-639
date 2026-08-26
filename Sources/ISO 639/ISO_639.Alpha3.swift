import ASCII
import Standard_Library_Extensions

extension ISO_639 {

    public struct Alpha3: Sendable, Equatable, Hashable {

        public let value: String

        public init(_ value: some StringProtocol) throws(Error) {
            let normalized = value.lowercased()

            guard normalized.count == 3 else {
                throw Alpha3.Error.invalidCodeLength(normalized.count)
            }

            guard normalized.allSatisfy({ $0.ascii.isLetter }) else {
                throw Alpha3.Error.invalidCharacters(normalized)
            }

            guard Self.validCodes.contains(normalized) else {
                throw Alpha3.Error.invalidAlpha3Code(normalized)
            }

            self.value = normalized
        }
    }
}

extension ISO_639.Alpha3 {

    internal init(unchecked value: String) {
        self.value = value
    }

    internal static let validCodes: Set<String> = {
        Set(allCases.map { $0.value })
    }()
}

extension ISO_639.Alpha3: CustomStringConvertible {
    public var description: String { value }
}

extension ISO_639.Alpha3: Codable {
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

extension ISO_639.Alpha3 {

    public init(_ alpha2: ISO_639.Alpha2) {

        guard let alpha3 = ISO_639.alpha2ToAlpha3[alpha2] else {
            preconditionFailure("ISO 639 Alpha-2 mapping is incomplete")
        }
        self = alpha3
    }
}
