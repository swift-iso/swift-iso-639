# swift-iso-639

Use this package when you need to validate, store or convert language codes: ISO 639-1 two-letter codes such as `en` and ISO 639-2 three-letter codes such as `eng`. Start from `ISO_639.Alpha2` or `ISO_639.Alpha3` when you know which form you have, and from `ISO_639.LanguageCode` when the input could be either. For script codes use swift-iso-15924, and for country codes use swift-iso-3166.

## Laws

- A code is valid only if it is in the package's tables: 183 two-letter codes and 486 three-letter codes. Any other code is refused.
- Three-letter codes are the ISO 639-2 terminology codes, such as `deu`, `fra` and `zho`. The bibliographic codes, such as `ger`, `fre` and `chi`, are accepted and stored as their terminology codes, so `ger` and `deu` give equal values. The collective and special codes, such as `afa`, `mis`, `mul`, `und` and `zxx`, are valid, and the local-use range from qaa to qtz is not.
- Codes are case-insensitive on input and always stored in lowercase, so `KO` and `ko` give equal values.
- Input must be ASCII. A character that only lowercases to an ASCII letter, such as the Kelvin sign, is refused.
- Every two-letter code has a three-letter code, its terminology code, so `de` becomes `deu`. Most three-letter codes have no two-letter code, and converting one gives nil. Converting a two-letter code to three letters and back gives the same code.
- `ISO_639.LanguageCode` reads two characters as a two-letter code and three as a three-letter code, and fills in the other form when one exists.
- An `ISO_639.LanguageCode` prints and encodes as its two-letter code when it has one, and as its three-letter code otherwise. Decoding `deu` and encoding the result gives `de`.
- Every type encodes as a single string, and decoding validates the string the same way the initializer does.
