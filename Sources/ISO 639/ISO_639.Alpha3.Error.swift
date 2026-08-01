// ISO_639.Alpha3.Error.swift
// ISO 639
//
// Error type for ISO 639 Alpha3 validation

extension ISO_639.Alpha3 {
    public enum Error: Swift.Error, Sendable, Equatable {
        /// Code length is invalid (must be 3)
        case invalidCodeLength(Int)

        /// Code contains invalid characters (must be ASCII letters only)
        case invalidCharacters(String)

        /// Three-letter code is not recognized
        case invalidAlpha3Code(String)
    }
}
