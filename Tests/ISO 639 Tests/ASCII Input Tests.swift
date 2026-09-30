import Testing

@testable import ISO_639

@Suite
struct `ASCII input` {
    @Test
    func `a Kelvin sign that lowercases to k is refused`() {
        #expect(throws: ISO_639.Alpha2.Error.self) { try ISO_639.Alpha2("\u{212A}o") }
        #expect(throws: ISO_639.Alpha3.Error.self) { try ISO_639.Alpha3("\u{212A}or") }
        #expect(throws: ISO_639.Error.self) { try ISO_639.LanguageCode("\u{212A}O") }
    }

    @Test
    func `ASCII codes in any case still parse`() throws {
        #expect(try ISO_639.Alpha2("KO").value == "ko")
        #expect(try ISO_639.Alpha3("Kor").value == "kor")
    }
}
