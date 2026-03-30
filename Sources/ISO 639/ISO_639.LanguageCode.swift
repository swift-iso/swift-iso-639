// ISO_639.LanguageCode.swift
// ISO 639
//
// Language code representation

import ASCII_Primitives
import Standard_Library_Extensions

extension ISO_639 {
    /// Language code per ISO 639
    ///
    /// Represents a language using either a 2-letter (ISO 639-1) or 3-letter (ISO 639-2/3) code.
    /// Stores the canonical form internally and provides conversions.
    ///
    /// ## Design Notes
    ///
    /// - Stores 2-letter code when available (most common form)
    /// - Falls back to 3-letter code for languages without 2-letter codes
    /// - Both forms validated using refined types
    /// - Provides bidirectional conversion when both forms exist
    ///
    /// ## Example
    ///
    /// ```swift
    /// let en = try ISO_639.LanguageCode("en")
    /// print(en.alpha2)  // "en"
    /// print(en.alpha3)  // "eng"
    ///
    /// let ara = try ISO_639.LanguageCode("ara")
    /// print(ara.alpha2)  // "ar"
    /// print(ara.alpha3)  // "ara"
    /// ```
    public struct LanguageCode: Sendable, Equatable, Hashable {
        /// Two-letter code (ISO 639-1), if available
        public let alpha2: Alpha2?

        /// Three-letter code (ISO 639-2/3)
        public let alpha3: Alpha3

        /// Creates a language code with refined types (total function)
        ///
        /// This initializer cannot fail because parameters are pre-validated refined types.
        ///
        /// - Parameters:
        ///   - alpha2: Two-letter code (optional)
        ///   - alpha3: Three-letter code (required)
        public init(alpha2: Alpha2?, alpha3: Alpha3) {
            self.alpha2 = alpha2
            self.alpha3 = alpha3
        }

        /// Creates a language code with only a 3-letter code (total function)
        ///
        /// Use this when the language has no ISO 639-1 two-letter code.
        ///
        /// - Parameter alpha3: Three-letter code
        public init(alpha3: Alpha3) {
            self.alpha2 = nil
            self.alpha3 = alpha3
        }
    }
}

// MARK: - Convenience Initializers

extension ISO_639.LanguageCode {
    /// Creates a language code from a string (partial function)
    ///
    /// Accepts either 2-letter or 3-letter codes and validates them.
    ///
    /// - Parameter code: Language code string (2 or 3 letters)
    /// - Throws: `ISO_639.Error` if the code is invalid
    public init(_ code: some StringProtocol) throws(ISO_639.Error) {
        let normalized = code.lowercased()

        switch normalized.count {
        case 2:
            // Validate and create alpha2
            do {
                let alpha2 = try ISO_639.Alpha2(normalized)
                // Use authoritative conversion to get alpha3
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
            // Validate and create alpha3
            do {
                let alpha3 = try ISO_639.Alpha3(normalized)
                // Use authoritative conversion to get alpha2 (if available)
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

// MARK: - String Representation

extension ISO_639.LanguageCode: CustomStringConvertible {
    /// Returns the preferred string representation (2-letter if available, otherwise 3-letter)
    public var description: String {
        alpha2?.value ?? alpha3.value
    }
}

// MARK: - Codable

extension ISO_639.LanguageCode: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }
}
