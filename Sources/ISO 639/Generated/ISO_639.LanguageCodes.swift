// ISO_639.LanguageCodes.swift
// ISO 639
//
// Language code data and mappings
//
// ⚠️ AUTO-GENERATED FILE - DO NOT EDIT DIRECTLY
// Generated from JSON data files using Scripts/generate-language-codes.swift
// To update: modify JSON files in Resources/ then run: swift Scripts/generate-language-codes.swift

import Standard_Library_Extensions

extension ISO_639 {
    /// Mapping from ISO 639-1 (2-letter) to ISO 639-2/T (3-letter) codes
    ///
    /// Complete ISO 639-1 standard (183 codes) with their ISO 639-2/T equivalents.
    /// Uses terminologic (T) codes, not bibliographic (B) codes.
    ///
    /// ## Data Source
    /// Generated from authoritative Library of Congress ISO 639-2 data.
    internal static let alpha2ToAlpha3: [Alpha2: Alpha3] = [
        .aa: .aar,  // Afar
        .ab: .abk,  // Abkhazian
        .af: .afr,  // Afrikaans
        .ak: .aka,  // Akan
        .sq: .sqi,  // Albanian
        .am: .amh,  // Amharic
        .ar: .ara,  // Arabic
        .an: .arg,  // Aragonese
        .hy: .hye,  // Armenian
        .`as`: .asm,  // Assamese
        .av: .ava,  // Avaric
        .ae: .ave,  // Avestan
        .ay: .aym,  // Aymara
        .az: .aze,  // Azerbaijani
        .ba: .bak,  // Bashkir
        .bm: .bam,  // Bambara
        .eu: .eus,  // Basque
        .be: .bel,  // Belarusian
        .bn: .ben,  // Bengali
        .bi: .bis,  // Bislama
        .bo: .bod,  // Tibetan
        .bs: .bos,  // Bosnian
        .br: .bre,  // Breton
        .bg: .bul,  // Bulgarian
        .my: .mya,  // Burmese
        .ca: .cat,  // Catalan; Valencian
        .cs: .ces,  // Czech
        .ch: .cha,  // Chamorro
        .ce: .che,  // Chechen
        .zh: .zho,  // Chinese
        // Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic
        .cu: .chu,
        .cv: .chv,  // Chuvash
        .kw: .cor,  // Cornish
        .co: .cos,  // Corsican
        .cr: .cre,  // Cree
        .cy: .cym,  // Welsh
        .da: .dan,  // Danish
        .de: .deu,  // German
        .dv: .div,  // Divehi; Dhivehi; Maldivian
        .nl: .nld,  // Dutch; Flemish
        .dz: .dzo,  // Dzongkha
        .el: .ell,  // Modern Greek (1453-)
        .en: .eng,  // English
        .eo: .epo,  // Esperanto
        .et: .est,  // Estonian
        .ee: .ewe,  // Ewe
        .fo: .fao,  // Faroese
        .fa: .fas,  // Persian
        .fj: .fij,  // Fijian
        .fi: .fin,  // Finnish
        .fr: .fra,  // French
        .fy: .fry,  // Western Frisian
        .ff: .ful,  // Fulah
        .gd: .gla,  // Gaelic; Scottish Gaelic
        .ga: .gle,  // Irish
        .gl: .glg,  // Galician
        .gv: .glv,  // Manx
        .gn: .grn,  // Guarani
        .gu: .guj,  // Gujarati
        .ht: .hat,  // Haitian; Haitian Creole
        .ha: .hau,  // Hausa
        .he: .heb,  // Hebrew
        .hz: .her,  // Herero
        .hi: .hin,  // Hindi
        .ho: .hmo,  // Hiri Motu
        .hr: .hrv,  // Croatian
        .hu: .hun,  // Hungarian
        .ig: .ibo,  // Igbo
        .`is`: .isl,  // Icelandic
        .io: .ido,  // Ido
        .ii: .iii,  // Sichuan Yi; Nuosu
        .iu: .iku,  // Inuktitut
        .ie: .ile,  // Interlingue; Occidental
        .ia: .ina,  // Interlingua (International Auxiliary Language Association)
        .id: .ind,  // Indonesian
        .ik: .ipk,  // Inupiaq
        .it: .ita,  // Italian
        .jv: .jav,  // Javanese
        .ja: .jpn,  // Japanese
        .kl: .kal,  // Kalaallisut; Greenlandic
        .kn: .kan,  // Kannada
        .ks: .kas,  // Kashmiri
        .kr: .kau,  // Kanuri
        .ka: .kat,  // Georgian
        .kk: .kaz,  // Kazakh
        .km: .khm,  // Central Khmer
        .ki: .kik,  // Kikuyu; Gikuyu
        .rw: .kin,  // Kinyarwanda
        .ky: .kir,  // Kirghiz; Kyrgyz
        .kv: .kom,  // Komi
        .kg: .kon,  // Kongo
        .ko: .kor,  // Korean
        .kj: .kua,  // Kuanyama; Kwanyama
        .ku: .kur,  // Kurdish
        .lo: .lao,  // Lao
        .la: .lat,  // Latin
        .lv: .lav,  // Latvian
        .li: .lim,  // Limburgan; Limburger; Limburgish
        .ln: .lin,  // Lingala
        .lt: .lit,  // Lithuanian
        .lb: .ltz,  // Luxembourgish; Letzeburgesch
        .lu: .lub,  // Luba-Katanga
        .lg: .lug,  // Ganda
        .mk: .mkd,  // Macedonian
        .mh: .mah,  // Marshallese
        .ml: .mal,  // Malayalam
        .mi: .mri,  // Maori
        .mr: .mar,  // Marathi
        .ms: .msa,  // Malay
        .mg: .mlg,  // Malagasy
        .mt: .mlt,  // Maltese
        .mn: .mon,  // Mongolian
        .na: .nau,  // Nauru
        .nv: .nav,  // Navajo; Navaho
        .nr: .nbl,  // South Ndebele
        .nd: .nde,  // North Ndebele
        .ng: .ndo,  // Ndonga
        .ne: .nep,  // Nepali
        .nn: .nno,  // Norwegian Nynorsk
        .nb: .nob,  // Norwegian Bokmål
        .no: .nor,  // Norwegian
        .ny: .nya,  // Chichewa; Chewa; Nyanja
        .oc: .oci,  // Occitan (post 1500)
        .oj: .oji,  // Ojibwa
        .or: .ori,  // Oriya
        .om: .orm,  // Oromo
        .os: .oss,  // Ossetian; Ossetic
        .pa: .pan,  // Panjabi; Punjabi
        .pi: .pli,  // Pali
        .pl: .pol,  // Polish
        .pt: .por,  // Portuguese
        .ps: .pus,  // Pushto; Pashto
        .qu: .que,  // Quechua
        .rm: .roh,  // Romansh
        .ro: .ron,  // Romanian; Moldavian; Moldovan
        .rn: .run,  // Rundi
        .ru: .rus,  // Russian
        .sg: .sag,  // Sango
        .sa: .san,  // Sanskrit
        .si: .sin,  // Sinhala; Sinhalese
        .sk: .slk,  // Slovak
        .sl: .slv,  // Slovenian
        .se: .sme,  // Northern Sami
        .sm: .smo,  // Samoan
        .sn: .sna,  // Shona
        .sd: .snd,  // Sindhi
        .so: .som,  // Somali
        .st: .sot,  // Sotho, Southern
        .es: .spa,  // Spanish; Castilian
        .sc: .srd,  // Sardinian
        .sr: .srp,  // Serbian
        .ss: .ssw,  // Swati
        .su: .sun,  // Sundanese
        .sw: .swa,  // Swahili
        .sv: .swe,  // Swedish
        .ty: .tah,  // Tahitian
        .ta: .tam,  // Tamil
        .tt: .tat,  // Tatar
        .te: .tel,  // Telugu
        .tg: .tgk,  // Tajik
        .tl: .tgl,  // Tagalog
        .th: .tha,  // Thai
        .ti: .tir,  // Tigrinya
        .to: .ton,  // Tonga (Tonga Islands)
        .tn: .tsn,  // Tswana
        .ts: .tso,  // Tsonga
        .tk: .tuk,  // Turkmen
        .tr: .tur,  // Turkish
        .tw: .twi,  // Twi
        .ug: .uig,  // Uighur; Uyghur
        .uk: .ukr,  // Ukrainian
        .ur: .urd,  // Urdu
        .uz: .uzb,  // Uzbek
        .ve: .ven,  // Venda
        .vi: .vie,  // Vietnamese
        .vo: .vol,  // Volapük
        .wa: .wln,  // Walloon
        .wo: .wol,  // Wolof
        .xh: .xho,  // Xhosa
        .yi: .yid,  // Yiddish
        .yo: .yor,  // Yoruba
        .za: .zha,  // Zhuang; Chuang
        .zu: .zul,  // Zulu
    ]

    /// Mapping from ISO 639-2 (3-letter) to ISO 639-1 (2-letter) codes
    internal static let alpha3ToAlpha2: [Alpha3: Alpha2] = {
        Dictionary(uniqueKeysWithValues: alpha2ToAlpha3.map { ($1, $0) })
    }()
}
