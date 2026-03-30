// ISO_639.Alpha2.swift
// ISO 639
//
// Two-letter language code (ISO 639-1)

import ASCII_Primitives
import Standard_Library_Extensions

extension ISO_639 {
    /// Two-letter language code per ISO 639-1
    ///
    /// Refined type representing a valid 2-letter language code.
    /// Common codes like "en", "zh", "es", "ar", etc.
    ///
    /// ## Validation
    ///
    /// - Exactly 2 ASCII letters
    /// - Lowercase
    /// - Must be a recognized ISO 639-1 code
    ///
    /// ## Example
    ///
    /// ```swift
    /// let en = try ISO_639.Alpha2("en")
    /// print(en.value)  // "en"
    /// ```
    public struct Alpha2: Sendable, Equatable, Hashable {
        /// The two-letter code value
        public let value: String

        /// Creates a two-letter code (partial function)
        ///
        /// Validates that the string is a recognized ISO 639-1 code.
        ///
        /// - Parameter value: Two-letter code string
        /// - Throws: `Alpha2.Error` if invalid
        public init(_ value: some StringProtocol) throws(Error) {
            let normalized = value.lowercased()

            // Validate length
            guard normalized.count == 2 else {
                throw Alpha2.Error.invalidCodeLength(normalized.count)
            }

            // Validate ASCII letters only
            guard normalized.allSatisfy({ $0.ascii.isLetter }) else {
                throw Alpha2.Error.invalidCharacters(normalized)
            }

            // Validate it's a recognized code
            guard Self.validCodes.contains(normalized) else {
                throw Alpha2.Error.invalidAlpha2Code(normalized)
            }

            self.value = normalized
        }
    }
}

extension ISO_639.Alpha2 {
    /// Creates a two-letter code without validation (internal use only)
    ///
    /// - Warning: Only use when the value is guaranteed to be valid
    /// - Parameter value: Pre-validated two-letter code
    internal init(unchecked value: String) {
        self.value = value
    }

    /// Set of valid ISO 639-1 (2-letter) code strings for validation
    ///
    /// Computed from `allCases` for consistency.
    internal static let validCodes: Set<String> = {
        Set(allCases.map { $0.value })
    }()
}

// MARK: - String Representation

extension ISO_639.Alpha2: CustomStringConvertible {
    public var description: String { value }
}

// MARK: - Codable

extension ISO_639.Alpha2: Codable {
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

extension ISO_639.Alpha2 {
    /// Converts a three-letter code to its two-letter equivalent (partial function)
    ///
    /// This is the authoritative conversion from ISO 639-2/T to ISO 639-1.
    /// Not all ISO 639-2 codes have ISO 639-1 equivalents. Returns `nil` for:
    /// - Language families (e.g., `"cel"`, `"gem"`, `"roa"`)
    /// - Ancient languages (e.g., `"grc"`, `"egy"`)
    /// - Special codes (e.g., `"mul"`, `"und"`, `"mis"`, `"zxx"`)
    /// - Other alpha3-only codes
    ///
    /// ## Performance
    /// - Time complexity: O(1) via hash table lookup
    /// - Space complexity: O(1)
    ///
    /// - Parameter alpha3: Three-letter language code
    /// - Returns: Two-letter code if available, `nil` otherwise
    public init?(_ alpha3: ISO_639.Alpha3) {
        // Performance: O(1) dictionary lookup
        guard let alpha2 = ISO_639.alpha3ToAlpha2[alpha3] else {
            return nil
        }
        self = alpha2
    }
}
