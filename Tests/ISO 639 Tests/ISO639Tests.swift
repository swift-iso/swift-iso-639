// ISO639Tests.swift
// ISO 639 Tests
//
// Comprehensive tests for ISO 639 language codes

import Foundation
import Testing

@testable import ISO_639

@Suite
struct `ISO 639 Language Codes` {

    // MARK: - Alpha2 Tests

    @Test
    func `Alpha2: Valid 2-letter codes`() throws {
        let en = try ISO_639.Alpha2("en")
        #expect(en.value == "en")

        let zh = try ISO_639.Alpha2("ZH")  // Test case normalization
        #expect(zh.value == "zh")

        let es = try ISO_639.Alpha2("Es")  // Test mixed case
        #expect(es.value == "es")
    }

    @Test
    func `Alpha2: Invalid length`() {
        #expect(throws: ISO_639.Alpha2.Error.invalidCodeLength(1)) {
            try ISO_639.Alpha2("e")
        }

        #expect(throws: ISO_639.Alpha2.Error.invalidCodeLength(3)) {
            try ISO_639.Alpha2("eng")
        }

        #expect(throws: ISO_639.Alpha2.Error.invalidCodeLength(0)) {
            try ISO_639.Alpha2("")
        }
    }

    @Test
    func `Alpha2: Invalid characters`() {
        #expect(throws: ISO_639.Alpha2.Error.invalidCharacters("e1")) {
            try ISO_639.Alpha2("e1")
        }

        #expect(throws: ISO_639.Alpha2.Error.invalidCharacters("e-")) {
            try ISO_639.Alpha2("e-")
        }

        #expect(throws: ISO_639.Alpha2.Error.invalidCharacters("e ")) {
            try ISO_639.Alpha2("e ")
        }
    }

    @Test
    func `Alpha2: Unrecognized code`() {
        #expect(throws: ISO_639.Alpha2.Error.invalidAlpha2Code("zz")) {
            try ISO_639.Alpha2("zz")
        }

        #expect(throws: ISO_639.Alpha2.Error.invalidAlpha2Code("xx")) {
            try ISO_639.Alpha2("xx")
        }
    }

    @Test
    func `Alpha2: Common static constants`() {
        #expect(ISO_639.Alpha2.en.value == "en")
        #expect(ISO_639.Alpha2.zh.value == "zh")
        #expect(ISO_639.Alpha2.es.value == "es")
        #expect(ISO_639.Alpha2.ar.value == "ar")
        #expect(ISO_639.Alpha2.fr.value == "fr")
        #expect(ISO_639.Alpha2.de.value == "de")
        #expect(ISO_639.Alpha2.ja.value == "ja")
        #expect(ISO_639.Alpha2.ru.value == "ru")
        #expect(ISO_639.Alpha2.pt.value == "pt")
        #expect(ISO_639.Alpha2.it.value == "it")
    }

    @Test
    func `Alpha2: String conversion`() {
        let en = ISO_639.Alpha2.en
        #expect(en.description == "en")
        #expect(String(describing: en) == "en")
    }

    @Test
    func `Alpha2: Equality and hashing`() throws {
        let en1 = try ISO_639.Alpha2("en")
        let en2 = try ISO_639.Alpha2("EN")
        let zh = try ISO_639.Alpha2("zh")

        #expect(en1 == en2)
        #expect(en1 != zh)
        #expect(en1.hashValue == en2.hashValue)
    }

    // MARK: - Alpha3 Tests

    @Test
    func `Alpha3: Valid 3-letter codes`() throws {
        let eng = try ISO_639.Alpha3("eng")
        #expect(eng.value == "eng")

        let zho = try ISO_639.Alpha3("ZHO")  // Test case normalization
        #expect(zho.value == "zho")

        let spa = try ISO_639.Alpha3("Spa")  // Test mixed case
        #expect(spa.value == "spa")
    }

    @Test
    func `Alpha3: Invalid length`() {
        #expect(throws: ISO_639.Alpha3.Error.invalidCodeLength(2)) {
            try ISO_639.Alpha3("en")
        }

        #expect(throws: ISO_639.Alpha3.Error.invalidCodeLength(4)) {
            try ISO_639.Alpha3("engl")
        }

        #expect(throws: ISO_639.Alpha3.Error.invalidCodeLength(0)) {
            try ISO_639.Alpha3("")
        }
    }

    @Test
    func `Alpha3: Invalid characters`() {
        #expect(throws: ISO_639.Alpha3.Error.invalidCharacters("en1")) {
            try ISO_639.Alpha3("en1")
        }

        #expect(throws: ISO_639.Alpha3.Error.invalidCharacters("en-")) {
            try ISO_639.Alpha3("en-")
        }

        #expect(throws: ISO_639.Alpha3.Error.invalidCharacters("en ")) {
            try ISO_639.Alpha3("en ")
        }
    }

    @Test
    func `Alpha3: Unrecognized code`() {
        #expect(throws: ISO_639.Alpha3.Error.invalidAlpha3Code("zzz")) {
            try ISO_639.Alpha3("zzz")
        }

        #expect(throws: ISO_639.Alpha3.Error.invalidAlpha3Code("xxx")) {
            try ISO_639.Alpha3("xxx")
        }
    }

    @Test
    func `Alpha3: Common static constants`() {
        #expect(ISO_639.Alpha3.eng.value == "eng")
        #expect(ISO_639.Alpha3.zho.value == "zho")
        #expect(ISO_639.Alpha3.spa.value == "spa")
        #expect(ISO_639.Alpha3.ara.value == "ara")
        #expect(ISO_639.Alpha3.fra.value == "fra")
        #expect(ISO_639.Alpha3.deu.value == "deu")
        #expect(ISO_639.Alpha3.jpn.value == "jpn")
        #expect(ISO_639.Alpha3.rus.value == "rus")
        #expect(ISO_639.Alpha3.por.value == "por")
        #expect(ISO_639.Alpha3.ita.value == "ita")
    }

    @Test
    func `Alpha3: String conversion`() {
        let eng = ISO_639.Alpha3.eng
        #expect(eng.description == "eng")
        #expect(String(describing: eng) == "eng")
    }

    @Test
    func `Alpha3: Equality and hashing`() throws {
        let eng1 = try ISO_639.Alpha3("eng")
        let eng2 = try ISO_639.Alpha3("ENG")
        let zho = try ISO_639.Alpha3("zho")

        #expect(eng1 == eng2)
        #expect(eng1 != zho)
        #expect(eng1.hashValue == eng2.hashValue)
    }

    // MARK: - LanguageCode Tests

    @Test
    func `LanguageCode: Initialize from 2-letter code`() throws {
        let en = try ISO_639.LanguageCode("en")
        #expect(en.alpha2?.value == "en")
        #expect(en.alpha3.value == "eng")
        #expect(en.description == "en")
    }

    @Test
    func `LanguageCode: Initialize from 3-letter code`() throws {
        let eng = try ISO_639.LanguageCode("eng")
        #expect(eng.alpha2?.value == "en")
        #expect(eng.alpha3.value == "eng")
        #expect(eng.description == "en")
    }

    @Test
    func `LanguageCode: Case normalization`() throws {
        let en1 = try ISO_639.LanguageCode("EN")
        let en2 = try ISO_639.LanguageCode("en")
        let en3 = try ISO_639.LanguageCode("En")

        #expect(en1 == en2)
        #expect(en2 == en3)
    }

    @Test
    func `LanguageCode: Bidirectional conversion consistency`() throws {
        // Test that creating from alpha2 and alpha3 yields same result
        let en2 = try ISO_639.LanguageCode("en")
        let en3 = try ISO_639.LanguageCode("eng")

        #expect(en2 == en3)
        #expect(en2.alpha2?.value == "en")
        #expect(en2.alpha3.value == "eng")
        #expect(en3.alpha2?.value == "en")
        #expect(en3.alpha3.value == "eng")
    }

    @Test
    func `LanguageCode: All major languages`() throws {
        let testCases: [(String, String, String)] = [
            ("en", "en", "eng"),  // English
            ("zh", "zh", "zho"),  // Chinese
            ("es", "es", "spa"),  // Spanish
            ("ar", "ar", "ara"),  // Arabic
            ("fr", "fr", "fra"),  // French
            ("de", "de", "deu"),  // German
            ("ja", "ja", "jpn"),  // Japanese
            ("ru", "ru", "rus"),  // Russian
            ("pt", "pt", "por"),  // Portuguese
            ("it", "it", "ita"),  // Italian
        ]

        for (input, expectedAlpha2, expectedAlpha3) in testCases {
            let code = try ISO_639.LanguageCode(input)
            #expect(code.alpha2?.value == expectedAlpha2)
            #expect(code.alpha3.value == expectedAlpha3)
        }
    }

    @Test
    func `LanguageCode: Indian languages`() throws {
        let testCases: [(String, String, String)] = [
            ("hi", "hi", "hin"),  // Hindi
            ("bn", "bn", "ben"),  // Bengali
            ("pa", "pa", "pan"),  // Punjabi
            ("te", "te", "tel"),  // Telugu
            ("mr", "mr", "mar"),  // Marathi
            ("ta", "ta", "tam"),  // Tamil
            ("ur", "ur", "urd"),  // Urdu
            ("gu", "gu", "guj"),  // Gujarati
            ("kn", "kn", "kan"),  // Kannada
            ("ml", "ml", "mal"),  // Malayalam
        ]

        for (input, expectedAlpha2, expectedAlpha3) in testCases {
            let code = try ISO_639.LanguageCode(input)
            #expect(code.alpha2?.value == expectedAlpha2)
            #expect(code.alpha3.value == expectedAlpha3)
        }
    }

    @Test
    func `LanguageCode: Initialize with refined types`() throws {
        let alpha2 = try ISO_639.Alpha2("en")
        let alpha3 = try ISO_639.Alpha3("eng")

        let code = ISO_639.LanguageCode(alpha2: alpha2, alpha3: alpha3)
        #expect(code.alpha2?.value == "en")
        #expect(code.alpha3.value == "eng")
    }

    @Test
    func `LanguageCode: Initialize with alpha3 only`() throws {
        let alpha3 = try ISO_639.Alpha3("eng")
        let code = ISO_639.LanguageCode(alpha3: alpha3)

        #expect(code.alpha2 == nil)
        #expect(code.alpha3.value == "eng")
    }

    @Test
    func `LanguageCode: String representation prefers alpha2`() throws {
        let withAlpha2 = try ISO_639.LanguageCode("en")
        #expect(withAlpha2.description == "en")

        let alpha3Only = ISO_639.LanguageCode(alpha3: .eng)
        #expect(alpha3Only.description == "eng")
    }

    @Test
    func `LanguageCode: Invalid codes`() {
        #expect(throws: ISO_639.Alpha2.Error.invalidAlpha2Code("zz")) {
            try ISO_639.LanguageCode("zz")
        }

        #expect(throws: ISO_639.Alpha3.Error.invalidAlpha3Code("zzz")) {
            try ISO_639.LanguageCode("zzz")
        }

        #expect(throws: ISO_639.Error.invalidCodeLength(1)) {
            try ISO_639.LanguageCode("e")
        }

        #expect(throws: ISO_639.Error.invalidCodeLength(4)) {
            try ISO_639.LanguageCode("engl")
        }
    }

    // MARK: - Codable Tests

    @Test
    func `Alpha2: Codable round-trip`() throws {
        let original = ISO_639.Alpha2.en
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let encoded = try encoder.encode(original)
        let decoded = try decoder.decode(ISO_639.Alpha2.self, from: encoded)

        #expect(decoded == original)
        #expect(decoded.value == "en")
    }

    @Test
    func `Alpha3: Codable round-trip`() throws {
        let original = ISO_639.Alpha3.eng
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let encoded = try encoder.encode(original)
        let decoded = try decoder.decode(ISO_639.Alpha3.self, from: encoded)

        #expect(decoded == original)
        #expect(decoded.value == "eng")
    }

    @Test
    func `LanguageCode: Codable round-trip`() throws {
        let original = try ISO_639.LanguageCode("en")
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let encoded = try encoder.encode(original)
        let decoded = try decoder.decode(ISO_639.LanguageCode.self, from: encoded)

        #expect(decoded == original)
        #expect(decoded.alpha2?.value == "en")
        #expect(decoded.alpha3.value == "eng")
    }

    @Test
    func `LanguageCode: Decode invalid code fails`() throws {
        let invalidJSON = Data("\"zz\"".utf8)
        let decoder = JSONDecoder()

        #expect(throws: ISO_639.Alpha2.Error.invalidAlpha2Code("zz")) {
            try decoder.decode(ISO_639.LanguageCode.self, from: invalidJSON)
        }
    }

    // MARK: - Edge Cases

    @Test
    func `Edge: Empty string`() {
        #expect(throws: ISO_639.Error.invalidCodeLength(0)) {
            try ISO_639.LanguageCode("")
        }
    }

    @Test
    func `Edge: Whitespace`() {
        #expect(throws: ISO_639.Alpha3.Error.invalidCharacters(" en")) {
            try ISO_639.LanguageCode(" en")
        }

        #expect(throws: ISO_639.Alpha3.Error.invalidCharacters("en ")) {
            try ISO_639.LanguageCode("en ")
        }

        #expect(throws: ISO_639.Error.invalidCodeLength(1)) {
            try ISO_639.LanguageCode(" ")
        }
    }

    @Test
    func `Edge: Unicode characters`() {
        #expect(throws: ISO_639.Alpha2.Error.invalidCharacters("ën")) {
            try ISO_639.LanguageCode("ën")
        }

        #expect(throws: ISO_639.Alpha2.Error.invalidCharacters("日本")) {
            try ISO_639.LanguageCode("日本")
        }
    }

    // MARK: - Special Codes

    @Test
    func `Special codes: Multiple languages`() throws {
        let mul = try ISO_639.Alpha3("mul")
        #expect(mul.value == "mul")
    }

    @Test
    func `Special codes: Undetermined`() throws {
        let und = try ISO_639.Alpha3("und")
        #expect(und.value == "und")
    }

    @Test
    func `Special codes: Uncoded`() throws {
        let mis = try ISO_639.Alpha3("mis")
        #expect(mis.value == "mis")
    }

    @Test
    func `Special codes: No linguistic content`() throws {
        let zxx = try ISO_639.Alpha3("zxx")
        #expect(zxx.value == "zxx")
    }

    // MARK: - Additional ISO 639-1 Codes

    @Test
    func `ISO 639-1: Constructed languages`() throws {
        let esperanto = try ISO_639.LanguageCode("eo")
        #expect(esperanto.alpha2?.value == "eo")
        #expect(esperanto.alpha3.value == "epo")

        let ido = try ISO_639.LanguageCode("io")
        #expect(ido.alpha2?.value == "io")
        #expect(ido.alpha3.value == "ido")

        let interlingua = try ISO_639.LanguageCode("ia")
        #expect(interlingua.alpha2?.value == "ia")
        #expect(interlingua.alpha3.value == "ina")
    }

    @Test
    func `ISO 639-1: Indigenous languages`() throws {
        let navajo = try ISO_639.LanguageCode("nv")
        #expect(navajo.alpha2?.value == "nv")
        #expect(navajo.alpha3.value == "nav")

        let quechua = try ISO_639.LanguageCode("qu")
        #expect(quechua.alpha2?.value == "qu")
        #expect(quechua.alpha3.value == "que")

        let inuktitut = try ISO_639.LanguageCode("iu")
        #expect(inuktitut.alpha2?.value == "iu")
        #expect(inuktitut.alpha3.value == "iku")
    }

    @Test
    func `ISO 639-1: Additional European languages`() throws {
        let breton = try ISO_639.LanguageCode("br")
        #expect(breton.alpha2?.value == "br")
        #expect(breton.alpha3.value == "bre")

        let scottishGaelic = try ISO_639.LanguageCode("gd")
        #expect(scottishGaelic.alpha2?.value == "gd")
        #expect(scottishGaelic.alpha3.value == "gla")

        let occitan = try ISO_639.LanguageCode("oc")
        #expect(occitan.alpha2?.value == "oc")
        #expect(occitan.alpha3.value == "oci")
    }

    @Test
    func `ISO 639-1: Norwegian variants`() throws {
        // Norwegian macrolanguage
        let norwegian = try ISO_639.LanguageCode("no")
        #expect(norwegian.alpha2?.value == "no")
        #expect(norwegian.alpha3.value == "nor")

        // Norwegian Bokmål
        let bokmal = try ISO_639.LanguageCode("nb")
        #expect(bokmal.alpha2?.value == "nb")
        #expect(bokmal.alpha3.value == "nob")

        // Norwegian Nynorsk
        let nynorsk = try ISO_639.LanguageCode("nn")
        #expect(nynorsk.alpha2?.value == "nn")
        #expect(nynorsk.alpha3.value == "nno")
    }

    // MARK: - Authoritative Conversions

    @Test
    func `Conversion: Alpha2 to Alpha3 (total function)`() throws {
        let en = try ISO_639.Alpha2("en")
        let eng = ISO_639.Alpha3(en)
        #expect(eng.value == "eng")

        let zh = try ISO_639.Alpha2("zh")
        let zho = ISO_639.Alpha3(zh)
        #expect(zho.value == "zho")

        let de = try ISO_639.Alpha2("de")
        let deu = ISO_639.Alpha3(de)
        #expect(deu.value == "deu")
    }

    @Test
    func `Conversion: Alpha3 to Alpha2 (partial function - success)`() throws {
        let eng = try ISO_639.Alpha3("eng")
        let en = ISO_639.Alpha2(eng)
        #expect(en != nil)
        #expect(en?.value == "en")

        let zho = try ISO_639.Alpha3("zho")
        let zh = ISO_639.Alpha2(zho)
        #expect(zh != nil)
        #expect(zh?.value == "zh")
    }

    @Test
    func `Conversion: Alpha3 to Alpha2 (partial function - nil)`() throws {
        // Language family (no alpha2)
        let cel = try ISO_639.Alpha3("cel")
        let celAlpha2 = ISO_639.Alpha2(cel)
        #expect(celAlpha2 == nil)

        // Ancient language (no alpha2)
        let grc = try ISO_639.Alpha3("grc")
        let grcAlpha2 = ISO_639.Alpha2(grc)
        #expect(grcAlpha2 == nil)

        // Special code (no alpha2)
        let mul = try ISO_639.Alpha3("mul")
        let mulAlpha2 = ISO_639.Alpha2(mul)
        #expect(mulAlpha2 == nil)
    }

    @Test
    func `Conversion: Round-trip Alpha2 → Alpha3 → Alpha2`() throws {
        let original = try ISO_639.Alpha2("fr")
        let alpha3 = ISO_639.Alpha3(original)
        let roundtrip = ISO_639.Alpha2(alpha3)

        #expect(roundtrip != nil)
        #expect(roundtrip?.value == original.value)
    }

    @Test
    func `Conversion: Performance characteristics`() throws {
        // Verify O(1) performance by testing many conversions
        let codes = ["en", "zh", "es", "ar", "fr", "de", "ja", "ru", "pt", "it"]

        for codeStr in codes {
            let alpha2 = try ISO_639.Alpha2(codeStr)
            let alpha3 = ISO_639.Alpha3(alpha2)
            let backToAlpha2 = ISO_639.Alpha2(alpha3)

            #expect(backToAlpha2?.value == codeStr)
        }
    }

    // MARK: - ISO 639-2 Codes Without Alpha2

    @Test
    func `ISO 639-2 only: Language families`() throws {
        let celtic = try ISO_639.Alpha3("cel")
        #expect(celtic.value == "cel")

        let germanic = try ISO_639.Alpha3("gem")
        #expect(germanic.value == "gem")

        let romance = try ISO_639.Alpha3("roa")
        #expect(romance.value == "roa")

        let slavic = try ISO_639.Alpha3("sla")
        #expect(slavic.value == "sla")
    }

    @Test
    func `ISO 639-2 only: Ancient languages`() throws {
        let ancientGreek = try ISO_639.Alpha3("grc")
        #expect(ancientGreek.value == "grc")

        let ancientEgyptian = try ISO_639.Alpha3("egy")
        #expect(ancientEgyptian.value == "egy")
    }

    @Test
    func `ISO 639-2 only: No alpha2 equivalent`() throws {
        // These codes have no ISO 639-1 equivalent
        let dravidian = try ISO_639.Alpha3("dra")
        #expect(dravidian.value == "dra")

        // LanguageCode with alpha3-only code
        let code = ISO_639.LanguageCode(alpha3: dravidian)
        #expect(code.alpha2 == nil)
        #expect(code.alpha3.value == "dra")
        #expect(code.description == "dra")  // Falls back to alpha3 when no alpha2
    }
}
