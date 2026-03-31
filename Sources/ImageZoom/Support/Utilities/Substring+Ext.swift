//
//  markbattistella.com
//  Created by Mark Battistella
//
//  Credit: https://github.com/finestructure/ImageAttributesPublishPlugin
//

import Foundation

extension Substring {

    /// Returns the substring enclosed by the first occurrence of the given delimiter pair.
    ///
    /// For example, given `"![alt text](image.jpg)"` and `.squareBrackets`, this returns
    /// `"alt text"`.
    ///
    /// - Parameter delimiter: The opening/closing character pair to search for.
    /// - Returns: The content between the delimiters, or `nil` if either character is missing
    ///   or the closing character appears before the opening one.
    func content(delimitedBy delimiter: Delimiter) -> Substring? {
        guard let openPos = firstIndex(of: delimiter.opening) else { return nil }
        let start = index(after: openPos)
        guard let end = firstIndex(of: delimiter.closing), start <= end else { return nil }
        return self[start..<end]
    }
}
