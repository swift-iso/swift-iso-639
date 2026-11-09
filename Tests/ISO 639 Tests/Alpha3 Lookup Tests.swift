import Testing

@testable import ISO_639

@Suite
struct `Alpha3 Lookup Tests` {

    @Test
    func `init(alpha3:) derives the two-letter code`() throws {
        #expect(ISO_639.LanguageCode(alpha3: .deu) == (try ISO_639.LanguageCode("deu")))
        #expect(ISO_639.LanguageCode(alpha3: .deu).alpha2 == .de)
    }

    @Test
    func `init(alpha3:) keeps nil for languages without a two-letter code`() {
        #expect(ISO_639.LanguageCode(alpha3: .ace).alpha2 == nil)
    }

    @Test
    func `Bibliographic codes map to terminology codes`() throws {
        #expect(try ISO_639.Alpha3("ger") == .deu)
        #expect(try ISO_639.Alpha3("FRE") == .fra)
        #expect(try ISO_639.LanguageCode("ger") == ISO_639.LanguageCode(alpha2: .de, alpha3: .deu))
    }

    @Test
    func `Every bibliographic code maps to a listed terminology code`() {
        for (bibliographic, terminology) in ISO_639.bibliographicToTerminology {
            #expect(ISO_639.Alpha3.validCodes.contains(terminology.value))
            #expect(!ISO_639.Alpha3.validCodes.contains(bibliographic))
        }
    }
}
