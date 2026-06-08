# swift-iso-639

**Type-safe ISO 639 language codes for Swift**

ISO 639 defines standardized codes for representing languages:
- **ISO 639-1**: Two-letter codes (e.g., `en`, `zh`, `es`)
- **ISO 639-2/3**: Three-letter codes (e.g., `eng`, `zho`, `spa`)

This package provides refined Swift types for working with ISO 639 language codes, ensuring type safety and validation at compile time and runtime.

## Features

- **Refined Types**: Type-safe `Alpha2` and `Alpha3` types for validated language codes
- **Bidirectional Conversion**: Automatic mapping between 2-letter and 3-letter codes
- **Static Constants**: Pre-defined constants for common languages (`.en`, `.eng`, etc.)
- **Codable Support**: Full JSON encoding/decoding with validation
- **Comprehensive Coverage**: ~70 major world languages included
- **Swift 6**: Built with Swift 6.0 language mode, fully Sendable

## Installation

### Swift Package Manager

Add this package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-iso/swift-iso-639", from: "0.1.0")
]
```

Then add it to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "ISO 639", package: "swift-iso-639")
    ]
)
```

## Usage

### Basic Usage

```swift
import ISO_639

// Create from 2-letter code
let english = try ISO_639.LanguageCode("en")
print(english.alpha2?.value)  // "en"
print(english.alpha3.value)   // "eng"

// Create from 3-letter code
let spanish = try ISO_639.LanguageCode("spa")
print(spanish.alpha2?.value)  // "es"
print(spanish.alpha3.value)   // "spa"

// Case insensitive
let french = try ISO_639.LanguageCode("FR")
print(french.alpha2?.value)   // "fr"
```

### Using Static Constants

```swift
// Common languages available as static constants
let english = ISO_639.Alpha2.en
let chinese = ISO_639.Alpha2.zh
let spanish = ISO_639.Alpha2.es

// 3-letter codes too
let eng = ISO_639.Alpha3.eng
let zho = ISO_639.Alpha3.zho
let spa = ISO_639.Alpha3.spa
```

### Refined Types

```swift
// Alpha2: Validated 2-letter code
let en = try ISO_639.Alpha2("en")
print(en.value)  // "en"

// Alpha3: Validated 3-letter code
let eng = try ISO_639.Alpha3("eng")
print(eng.value)  // "eng"

// Compose into LanguageCode (total function - never fails)
let code = ISO_639.LanguageCode(alpha2: en, alpha3: eng)
```

### Error Handling

```swift
do {
    let invalid = try ISO_639.LanguageCode("zz")
} catch ISO_639.Error.invalidAlpha2Code(let code) {
    print("Invalid 2-letter code: \(code)")
}

do {
    let invalid = try ISO_639.LanguageCode("zzz")
} catch ISO_639.Error.invalidAlpha3Code(let code) {
    print("Invalid 3-letter code: \(code)")
}

do {
    let invalid = try ISO_639.LanguageCode("e")
} catch ISO_639.Error.invalidCodeLength(let length) {
    print("Invalid length: \(length)")
}

do {
    let invalid = try ISO_639.LanguageCode("e1")
} catch ISO_639.Error.invalidCharacters(let code) {
    print("Invalid characters: \(code)")
}
```

### Codable

```swift
struct Document: Codable {
    let language: ISO_639.LanguageCode
    let title: String
}

// Encoding
let doc = Document(
    language: try ISO_639.LanguageCode("en"),
    title: "Hello World"
)
let json = try JSONEncoder().encode(doc)
// {"language":"en","title":"Hello World"}

// Decoding with validation
let decoded = try JSONDecoder().decode(Document.self, from: json)
print(decoded.language.alpha2?.value)  // "en"
```

## Supported Languages

The package includes ~70 major world languages:

### Major World Languages
- English (`en`/`eng`), Chinese (`zh`/`zho`), Spanish (`es`/`spa`)
- Arabic (`ar`/`ara`), French (`fr`/`fra`), German (`de`/`deu`)
- Japanese (`ja`/`jpn`), Russian (`ru`/`rus`), Portuguese (`pt`/`por`)
- Italian (`it`/`ita`)

### Indian Languages
- Hindi (`hi`/`hin`), Bengali (`bn`/`ben`), Punjabi (`pa`/`pan`)
- Telugu (`te`/`tel`), Marathi (`mr`/`mar`), Tamil (`ta`/`tam`)
- Urdu (`ur`/`urd`), Gujarati (`gu`/`guj`), Kannada (`kn`/`kan`)
- Malayalam (`ml`/`mal`)

### European Languages
- Polish (`pl`/`pol`), Ukrainian (`uk`/`ukr`), Romanian (`ro`/`ron`)
- Dutch (`nl`/`nld`), Greek (`el`/`ell`), Swedish (`sv`/`swe`)
- Czech (`cs`/`ces`), Hungarian (`hu`/`hun`), Finnish (`fi`/`fin`)

### Other Languages
- Korean (`ko`/`kor`), Vietnamese (`vi`/`vie`), Turkish (`tr`/`tur`)
- Thai (`th`/`tha`), Persian (`fa`/`fas`), Swahili (`sw`/`swa`)
- And many more...

See `ISO_639.LanguageCodes.swift` for the complete list.

## Design Philosophy

This package follows refined type principles:

- **Total Functions**: Functions with refined type parameters never throw
- **Partial Functions**: Functions with raw string parameters validate and throw
- **Immutability**: All types are immutable value types
- **Sendability**: All types are `Sendable` for safe concurrency
- **No Foundation**: Pure Swift implementation with no Foundation dependency

### Type Safety

```swift
// This is a total function - never fails
func processLanguage(_ code: ISO_639.LanguageCode) {
    print(code.alpha3.value)
}

// This is a partial function - validates input
func parseLanguage(_ input: String) throws -> ISO_639.LanguageCode {
    try ISO_639.LanguageCode(input)
}
```

## API Reference

### `ISO_639.LanguageCode`

Main type representing a language code.

```swift
public struct LanguageCode: Sendable, Equatable, Hashable, Codable {
    public let alpha2: Alpha2?  // Optional 2-letter code
    public let alpha3: Alpha3   // Required 3-letter code

    // Total function with refined types
    public init(alpha2: Alpha2?, alpha3: Alpha3)

    // Total function with alpha3 only
    public init(alpha3: Alpha3)

    // Partial function from string
    public init(_ code: String) throws
}
```

### `ISO_639.Alpha2`

Refined type for 2-letter codes (ISO 639-1).

```swift
public struct Alpha2: Sendable, Equatable, Hashable, Codable {
    public let value: String

    // Partial function - validates input
    public init(_ value: String) throws

    // Static constants
    public static let en: Alpha2
    public static let zh: Alpha2
    // ... and more
}
```

### `ISO_639.Alpha3`

Refined type for 3-letter codes (ISO 639-2/3).

```swift
public struct Alpha3: Sendable, Equatable, Hashable, Codable {
    public let value: String

    // Partial function - validates input
    public init(_ value: String) throws

    // Static constants
    public static let eng: Alpha3
    public static let zho: Alpha3
    // ... and more
}
```

### `ISO_639.Error`

Errors thrown during validation.

```swift
public enum Error: Swift.Error, Sendable, Equatable, LocalizedError {
    case invalidCodeLength(Int)
    case invalidCharacters(String)
    case invalidAlpha2Code(String)
    case invalidAlpha3Code(String)
}
```

## Testing

The package includes comprehensive tests covering:

- Valid and invalid code validation
- Case normalization
- Bidirectional alpha2 ↔ alpha3 conversion
- Static constants
- Codable round-trips
- Error handling
- Edge cases

Run tests with:

```bash
swift test
```

Or with Xcode:

```bash
xcodebuild -workspace Standards.xcworkspace \
  -scheme "ISO 639" \
  -destination 'platform=macOS' \
  test
```

## Standards Compliance

This implementation follows:
- **ISO 639-1**: Two-letter language codes (1988)
- **ISO 639-2**: Three-letter language codes (1998)
- **ISO 639-3**: Comprehensive three-letter codes (2007)

The package uses ISO 639-2/B (bibliographic) codes where applicable.

## Related Packages

- [swift-standards](https://github.com/swift-standards/swift-standards) - Foundation types
- [swift-iso-3166](https://github.com/swift-iso/swift-iso-3166) - Country codes (planned)
- [swift-bcp-47](https://github.com/swift-standards/swift-bcp-47) - Language tags (planned)

## License

MIT License. See LICENSE for details.

## Contributing

Contributions welcome! Please ensure:
- All tests pass
- New code follows existing patterns
- Documentation is updated
- Refined type principles are maintained
