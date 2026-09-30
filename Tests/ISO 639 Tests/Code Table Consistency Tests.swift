import Testing

@testable import ISO_639

@Suite
struct `Code table consistency` {
    @Test
    func `an alpha-3 code with an alpha-2 counterpart maps back to itself`() {
        for alpha3 in ISO_639.Alpha3.allCases {
            if let alpha2 = ISO_639.Alpha2(alpha3) {
                #expect(ISO_639.Alpha3(alpha2) == alpha3)
            }
        }
    }

    @Test
    func `every alpha-2 code parses as a language code in either case`() throws {
        for alpha2 in ISO_639.Alpha2.allCases {
            #expect(try ISO_639.LanguageCode(alpha2.value.uppercased()).alpha2 == alpha2)
        }
    }
}
