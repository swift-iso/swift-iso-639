import Testing

@testable import ISO_639

enum `ASCII Input Tests` {}

extension `ASCII Input Tests` {
    @Suite
    struct `ASCII input` {
        @Test
        func `a Kelvin sign that lowercases to k is refused`() {
            #expect(throws: ISO.`639`.Alpha2.Error.self) { try ISO.`639`.Alpha2("\u{212A}o") }
            #expect(throws: ISO.`639`.Alpha3.Error.self) { try ISO.`639`.Alpha3("\u{212A}or") }
            #expect(throws: ISO.`639`.Error.self) { try ISO.`639`.LanguageCode("\u{212A}O") }
        }

        @Test
        func `ASCII codes in any case still parse`() throws {
            #expect(try ISO.`639`.Alpha2("KO").value == "ko")
            #expect(try ISO.`639`.Alpha3("Kor").value == "kor")
        }
    }
}
