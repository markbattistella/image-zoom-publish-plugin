//
//  markbattistella.com
//  Created by Mark Battistella
//

import Foundation

/// The bracket styles used when extracting delimited content from markdown substrings.
enum Delimiter {

    /// Square brackets — used to capture the alt text in `![alt](url)`.
    case squareBrackets

    /// Parentheses — used to capture the URL and flags in `![alt](url flags)`.
    case parentheses

    /// The opening character for this delimiter.
    var opening: Character {
        switch self {
        case .squareBrackets: return "["
        case .parentheses:    return "("
        }
    }

    /// The closing character for this delimiter.
    var closing: Character {
        switch self {
        case .squareBrackets: return "]"
        case .parentheses:    return ")"
        }
    }
}
