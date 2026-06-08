#!/usr/bin/env swift

import Foundation

// MARK: - Data Models

struct LanguageMapping: Codable {
    let alpha2: String
    let alpha3: String
    let name: String
}

struct LanguageAlpha3Only: Codable {
    let alpha3: String
    let name: String
}

// MARK: - Swift Keywords
//
// NOTE: Keep in sync with Set<String>.swiftKeywords in Standards package

let swiftKeywords: Set<String> = [
    "as", "break", "case", "catch", "class", "continue", "default", "defer",
    "do", "else", "enum", "extension", "fallthrough", "false", "fileprivate",
    "for", "func", "guard", "if", "import", "in", "init", "inout", "internal",
    "is", "let", "nil", "operator", "private", "protocol", "public", "repeat",
    "return", "self", "Self", "static", "struct", "subscript", "super", "switch",
    "throw", "throws", "true", "try", "typealias", "var", "where", "while"
]

/// Escapes a code if it's a Swift keyword
func escapeIfNeeded(_ code: String) -> String {
    swiftKeywords.contains(code) ? "`\(code)`" : code
}

// MARK: - Code Generation

func generateLanguageCodesFile() throws {
    let scriptURL = URL(fileURLWithPath: #filePath)
    let scriptsDir = scriptURL.deletingLastPathComponent()
    let projectDir = scriptsDir.deletingLastPathComponent()
    let resourcesDir = projectDir.appendingPathComponent("Sources/ISO 639/Data")
    let generatedDir = projectDir.appendingPathComponent("Sources/ISO 639/Generated")

    // Create Generated directory if it doesn't exist
    try FileManager.default.createDirectory(at: generatedDir, withIntermediateDirectories: true)

    let outputFile = generatedDir.appendingPathComponent("ISO_639.LanguageCodes.swift")
    let alpha2AccessorsFile = generatedDir.appendingPathComponent("ISO_639.Alpha2+StaticAccessors.swift")
    let alpha3AccessorsFile = generatedDir.appendingPathComponent("ISO_639.Alpha3+StaticAccessors.swift")
    let alpha2CaseIterableFile = generatedDir.appendingPathComponent("ISO_639.Alpha2+CaseIterable.swift")
    let alpha3CaseIterableFile = generatedDir.appendingPathComponent("ISO_639.Alpha3+CaseIterable.swift")

    // Load JSON data
    let mappingsURL = resourcesDir.appendingPathComponent("iso-639-1.json")
    let alpha3OnlyURL = resourcesDir.appendingPathComponent("iso-639-2-alpha3only.json")

    let mappingsData = try Data(contentsOf: mappingsURL)
    let alpha3OnlyData = try Data(contentsOf: alpha3OnlyURL)

    let mappings = try JSONDecoder().decode([LanguageMapping].self, from: mappingsData)
    let alpha3Only = try JSONDecoder().decode([LanguageAlpha3Only].self, from: alpha3OnlyData)

    // Generate code
    var output = """
    // ISO_639.LanguageCodes.swift
    // ISO 639
    //
    // Language code data and mappings
    //
    // ⚠️ AUTO-GENERATED FILE - DO NOT EDIT DIRECTLY
    // Generated from JSON data files using Scripts/generate-language-codes.swift
    // To update: modify JSON files in Resources/ then run: swift Scripts/generate-language-codes.swift

    import Standards

    extension ISO_639 {
        /// Mapping from ISO 639-1 (2-letter) to ISO 639-2/T (3-letter) codes
        ///
        /// Complete ISO 639-1 standard (\(mappings.count) codes) with their ISO 639-2/T equivalents.
        /// Uses terminologic (T) codes, not bibliographic (B) codes.
        ///
        /// ## Data Source
        /// Generated from authoritative Library of Congress ISO 639-2 data.
        internal static let alpha2ToAlpha3: [Alpha2: Alpha3] = [

    """

    // Add mappings with refined types
    for (index, mapping) in mappings.enumerated() {
        let comma = index < mappings.count - 1 ? "," : ""
        output += "        .\(escapeIfNeeded(mapping.alpha2)): .\(mapping.alpha3)\(comma)  // \(mapping.name)\n"
    }

    output += """
        ]

        /// Mapping from ISO 639-2 (3-letter) to ISO 639-1 (2-letter) codes
        internal static let alpha3ToAlpha2: [Alpha3: Alpha2] = {
            Dictionary(uniqueKeysWithValues: alpha2ToAlpha3.map { ($1, $0) })
        }()
    }

    """

    // Write output
    try output.write(to: outputFile, atomically: true, encoding: .utf8)

    // Generate Alpha2 static accessors
    var alpha2Accessors = """
    // ISO_639.Alpha2+StaticAccessors.swift
    // ISO 639
    //
    // Static accessors for all ISO 639-1 (2-letter) codes
    //
    // ⚠️ AUTO-GENERATED FILE - DO NOT EDIT DIRECTLY
    // Generated from JSON data files using Scripts/generate-language-codes.swift
    // To update: modify JSON files in Resources/ then run: swift Scripts/generate-language-codes.swift

    extension ISO_639.Alpha2 {

    """

    for mapping in mappings {
        alpha2Accessors += "    /// \(mapping.name)\n"
        alpha2Accessors += "    public static let \(escapeIfNeeded(mapping.alpha2)) = ISO_639.Alpha2(unchecked: \"\(mapping.alpha2)\")\n\n"
    }

    alpha2Accessors += "}\n"
    try alpha2Accessors.write(to: alpha2AccessorsFile, atomically: true, encoding: .utf8)

    // Generate Alpha3 static accessors
    var alpha3Accessors = """
    // ISO_639.Alpha3+StaticAccessors.swift
    // ISO 639
    //
    // Static accessors for all ISO 639-2/3 (3-letter) codes
    //
    // ⚠️ AUTO-GENERATED FILE - DO NOT EDIT DIRECTLY
    // Generated from JSON data files using Scripts/generate-language-codes.swift
    // To update: modify JSON files in Resources/ then run: swift Scripts/generate-language-codes.swift

    extension ISO_639.Alpha3 {

    """

    // Generate from mappings (codes with alpha2 equivalents)
    for mapping in mappings {
        alpha3Accessors += "    /// \(mapping.name)\n"
        alpha3Accessors += "    public static let \(escapeIfNeeded(mapping.alpha3)) = ISO_639.Alpha3(unchecked: \"\(mapping.alpha3)\")\n\n"
    }

    // Generate from alpha3-only codes
    for code in alpha3Only {
        alpha3Accessors += "    /// \(code.name)\n"
        alpha3Accessors += "    public static let \(escapeIfNeeded(code.alpha3)) = ISO_639.Alpha3(unchecked: \"\(code.alpha3)\")\n\n"
    }

    alpha3Accessors += "}\n"
    try alpha3Accessors.write(to: alpha3AccessorsFile, atomically: true, encoding: .utf8)

    // Generate Alpha2 CaseIterable conformance
    var alpha2CaseIterable = """
    // ISO_639.Alpha2+CaseIterable.swift
    // ISO 639
    //
    // CaseIterable conformance for ISO 639-1 (2-letter) codes
    //
    // ⚠️ AUTO-GENERATED FILE - DO NOT EDIT DIRECTLY
    // Generated from JSON data files using Scripts/generate-language-codes.swift
    // To update: modify JSON files in Resources/ then run: swift Scripts/generate-language-codes.swift

    extension ISO_639.Alpha2: CaseIterable {
        public static let allCases: [ISO_639.Alpha2] = [

    """

    for (index, mapping) in mappings.enumerated() {
        let comma = index < mappings.count - 1 ? "," : ""
        alpha2CaseIterable += "        .\(escapeIfNeeded(mapping.alpha2))\(comma)\n"
    }

    alpha2CaseIterable += """
        ]
    }

    """
    try alpha2CaseIterable.write(to: alpha2CaseIterableFile, atomically: true, encoding: .utf8)

    // Generate Alpha3 CaseIterable conformance
    var alpha3CaseIterable = """
    // ISO_639.Alpha3+CaseIterable.swift
    // ISO 639
    //
    // CaseIterable conformance for ISO 639-2/3 (3-letter) codes
    //
    // ⚠️ AUTO-GENERATED FILE - DO NOT EDIT DIRECTLY
    // Generated from JSON data files using Scripts/generate-language-codes.swift
    // To update: modify JSON files in Resources/ then run: swift Scripts/generate-language-codes.swift

    extension ISO_639.Alpha3: CaseIterable {
        public static let allCases: [ISO_639.Alpha3] = [

    """

    let allAlpha3Codes = mappings.map { $0.alpha3 } + alpha3Only.map { $0.alpha3 }
    for (index, code) in allAlpha3Codes.sorted().enumerated() {
        let comma = index < allAlpha3Codes.count - 1 ? "," : ""
        alpha3CaseIterable += "        .\(code)\(comma)\n"
    }

    alpha3CaseIterable += """
        ]
    }

    """
    try alpha3CaseIterable.write(to: alpha3CaseIterableFile, atomically: true, encoding: .utf8)

    print("✅ Generated ISO_639.LanguageCodes.swift")
    print("   - \(mappings.count) ISO 639-1 codes (with alpha2↔alpha3 mappings)")
    print("   - \(alpha3Only.count) ISO 639-2 alpha3-only codes")
    print("   - \(mappings.count + alpha3Only.count) total codes")
    print("")
    print("✅ Generated ISO_639.Alpha2+StaticAccessors.swift")
    print("   - \(mappings.count) static accessors")
    print("")
    print("✅ Generated ISO_639.Alpha3+StaticAccessors.swift")
    print("   - \(mappings.count + alpha3Only.count) static accessors")
    print("")
    print("✅ Generated ISO_639.Alpha2+CaseIterable.swift")
    print("   - \(mappings.count) cases")
    print("")
    print("✅ Generated ISO_639.Alpha3+CaseIterable.swift")
    print("   - \(mappings.count + alpha3Only.count) cases")
}

// MARK: - Main

do {
    try generateLanguageCodesFile()
} catch {
    print("❌ Error: \(error)")
    exit(1)
}
