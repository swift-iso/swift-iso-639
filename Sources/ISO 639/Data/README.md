# ISO 639 Language Code Data

This directory contains authoritative ISO 639 language code data files.

## Data Files

### `iso-639-1.json`
Contains all **183 ISO 639-1 codes** (2-letter codes) with their ISO 639-2/T (3-letter) equivalents.

**Structure:**
```json
{
  "alpha2": "en",    // ISO 639-1 (2-letter code)
  "alpha3": "eng",   // ISO 639-2/T (3-letter code, terminologic)
  "name": "English"  // English name
}
```

### `iso-639-2-alpha3only.json`
Contains **303 ISO 639-2 codes** that have no ISO 639-1 equivalent.

Includes:
- Language families (e.g., `cel` = Celtic languages, `gem` = Germanic languages)
- Ancient languages (e.g., `grc` = Ancient Greek, `egy` = Ancient Egyptian)
- Special codes (e.g., `mul` = Multiple languages, `und` = Undetermined)
- Indigenous and regional languages without 2-letter codes

**Structure:**
```json
{
  "alpha3": "cel",           // ISO 639-2 (3-letter code)
  "name": "Celtic languages" // English name
}
```

## Data Source

All data is sourced from the **Library of Congress** official ISO 639-2 registry:
- URL: https://www.loc.gov/standards/iso639-2/
- Standard: ISO 639-2 (Terminologic codes, not Bibliographic)
- Total: **486 language codes**

## Code Generation

The Swift code in `ISO_639.LanguageCodes.swift` is **automatically generated** from these JSON files.

### To Update Data

1. Edit the JSON files in this directory
2. Run the generation script:
   ```bash
   swift Scripts/generate-language-codes.swift
   ```
3. Verify tests pass:
   ```bash
   swift test
   ```

## Why Code Generation?

This approach follows the **"Don't Repeat Yourself" (DRY)** principle:

- **Single source of truth**: JSON files are authoritative
- **No manual maintenance**: 486 codes would be error-prone to maintain by hand
- **Verifiable**: JSON can be validated against official sources
- **Updatable**: Easy to incorporate ISO 639 updates
- **No runtime overhead**: Generated Swift code is as fast as hand-written code

## Alternative Considered: Macros

Swift macros were considered but have trade-offs:
- ✅ Compile-time generation
- ❌ Complex setup (SwiftSyntax dependency, macro target)
- ❌ Difficult to access resources at macro-expansion time
- ❌ Harder to debug generated code

The code generation script approach is simpler and more maintainable for a standards library.
