// ISO_639.Alpha2.Error.swift
// ISO 639
//
// Error type for ISO 639 Alpha2 validation

extension ISO_639.Alpha2 {
    public enum Error: Swift.Error, Sendable, Equatable {
        /// Code length is invalid (must be 2)
        case invalidCodeLength(Int)

        /// Code contains invalid characters (must be ASCII letters only)
        case invalidCharacters(String)

        /// Two-letter code is not recognized
        case invalidAlpha2Code(String)
    }
}
