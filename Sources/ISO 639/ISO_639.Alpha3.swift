// ISO_639.Alpha3.swift
// ISO 639
//
// Three-letter language code (ISO 639-2/3)

import ASCII_Primitives
import Standard_Library_Extensions

extension ISO_639 {
    /// Three-letter language code per ISO 639-2/3
    ///
    /// Refined type representing a valid 3-letter language code.
    /// Common codes like "eng", "zho", "spa", "ara", etc.
    ///
    /// ## Validation
    ///
    /// - Exactly 3 ASCII letters
    /// - Lowercase
    /// - Must be a recognized ISO 639-2 or ISO 639-3 code
    ///
    /// ## Example
    ///
    /// ```swift
    /// let eng = try ISO_639.Alpha3("eng")
    /// print(eng.value)  // "eng"
    /// ```
    public struct Alpha3: Sendable, Equatable, Hashable {
        /// The three-letter code value
        public let value: String

        /// Creates a three-letter code (partial function)
        ///
        /// Validates that the string is a recognized ISO 639-2/3 code.
        ///
        /// - Parameter value: Three-letter code string
        /// - Throws: `Alpha3.Error` if invalid
        public init(_ value: some StringProtocol) throws(Error) {
            let normalized = value.lowercased()

            // Validate length
            guard normalized.count == 3 else {
                throw Alpha3.Error.invalidCodeLength(normalized.count)
            }

            // Validate ASCII letters only
            guard normalized.allSatisfy({ $0.ascii.isLetter }) else {
                throw Alpha3.Error.invalidCharacters(normalized)
            }

            // Validate it's a recognized code
            guard Self.validCodes.contains(normalized) else {
                throw Alpha3.Error.invalidAlpha3Code(normalized)
            }

            self.value = normalized
        }
    }
}

extension ISO_639.Alpha3 {
    /// Creates a three-letter code without validation (internal use only)
    ///
    /// - Warning: Only use when the value is guaranteed to be valid
    /// - Parameter value: Pre-validated three-letter code
    internal init(unchecked value: String) {
        self.value = value
    }

    /// Set of valid ISO 639-2/3 (3-letter) code strings for validation
    ///
    /// Computed from `allCases` for consistency.
    internal static let validCodes: Set<String> = {
        Set(allCases.map { $0.value })
    }()
}

// MARK: - String Representation

extension ISO_639.Alpha3: CustomStringConvertible {
    public var description: String { value }
}

// MARK: - Codable

extension ISO_639.Alpha3: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }
}

extension ISO_639.Alpha3 {
    /// Converts a two-letter code to its three-letter equivalent (total function)
    ///
    /// This is the authoritative conversion from ISO 639-1 to ISO 639-2/T.
    /// All ISO 639-1 codes have corresponding ISO 639-2/T codes by definition,
    /// so this conversion never fails.
    ///
    /// ## Performance
    /// - Time complexity: O(1) via hash table lookup
    /// - Space complexity: O(1)
    ///
    /// - Parameter alpha2: Two-letter language code
    public init(_ alpha2: ISO_639.Alpha2) {
        // Performance: O(1) dictionary lookup
        // Force unwrap is safe: all ISO 639-1 codes have ISO 639-2/T equivalents
        let alpha3 = ISO_639.alpha2ToAlpha3[alpha2]!
        self = alpha3
    }
}
