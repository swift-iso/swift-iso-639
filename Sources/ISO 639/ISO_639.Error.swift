// ISO_639.Error.swift
// ISO 639
//
// Error types for ISO 639 validation

import Standard_Library_Extensions

extension ISO_639 {
    /// Errors that can occur when working with language codes
    public enum Error: Swift.Error, Sendable, Equatable {
        /// Code length is invalid (must be 2 or 3)
        case invalidCodeLength(Int)

        /// Code contains invalid characters (must be ASCII letters only)
        case invalidCharacters(String)

        /// Two-letter code is not recognized
        case invalidAlpha2Code(String)

        /// Three-letter code is not recognized
        case invalidAlpha3Code(String)
    }
}
