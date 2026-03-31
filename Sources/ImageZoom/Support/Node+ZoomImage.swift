//
//  markbattistella.com
//  Created by Mark Battistella
//

import Plot
import Publish

public extension Node where Context == HTML.BodyContext {

    /// Inserts the image zoom script into your page.
    ///
    /// Add this once to your theme — typically at the end of `<body>` or in your footer:
    ///
    /// ```swift
    /// extension Node where Context == HTML.BodyContext {
    ///     static func footer(for site: MyWebsite) -> Node {
    ///         .footer(
    ///             ...
    ///             .zoomImageScripts()
    ///         )
    ///     }
    /// }
    /// ```
    static func zoomImageScripts() -> Node {
        .script(.src("/zoom-image.js"), .attribute(named: "defer", value: ""))
    }
}
