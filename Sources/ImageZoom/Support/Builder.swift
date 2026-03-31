//
//  markbattistella.com
//  Created by Mark Battistella
//

import Foundation
import Publish
import Ink
import Plot

/// Parses an Ink image markdown node and produces a zoomable HTML figure element.
struct Builder {

    /// Transforms an image markdown node into a `<figure>` element with zoom support.
    ///
    /// Recognises two optional tokens after the image URL in the markdown source:
    /// - `nozoom` — disables zoom on this image
    /// - `zoomsrc=<url>` — provides a high-resolution URL loaded when zooming
    ///
    /// - Parameters:
    ///   - options: The zoom configuration applied to all images.
    ///   - html: The default HTML string produced by the Ink parser (used as fallback).
    ///   - markdown: The raw markdown substring for the image node.
    /// - Returns: Rendered HTML string for the figure, or the original `html` if parsing fails.
    func zoom(options: ZoomOptions, html: String, markdown: Substring) -> String {
        guard
            let text = markdown.content(delimitedBy: .squareBrackets),
            let link = markdown.content(delimitedBy: .parentheses)
        else { return html }

        let parts = link
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }

        let imageUrl = parts[0]
        let flags = parts.dropFirst()

        let isZoomable = !flags.contains { $0.lowercased() == "nozoom" }
        let zoomSrc = flags
            .first { $0.lowercased().hasPrefix("zoomsrc=") }
            .map { String($0.dropFirst("zoomsrc=".count)) }

        let imgNode: Node<HTML.BodyContext>
        if let zoomSrc {
            imgNode = .img(
                .src(imageUrl),
                .alt(String(text)),
                .title(String(text)),
                .data(named: "zoomable", value: "\(isZoomable)"),
                .data(named: "zoom-src", value: zoomSrc)
            )
        } else {
            imgNode = .img(
                .src(imageUrl),
                .alt(String(text)),
                .title(String(text)),
                .data(named: "zoomable", value: "\(isZoomable)")
            )
        }

        let node: Node<HTML.BodyContext> = .figure(
            imgNode,
            .if(options.showCaption && !text.isEmpty, .figcaption(.text(String(text))))
        )

        return node.render()
    }
}
