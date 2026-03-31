//
//  Created by Mark Battistella
//	markbattistella.com
//

import Foundation
import Publish
import Ink
import Plot

// MARK: - the magic
final class Builder {

    func zoom(options: ZoomOptions, html: String, markdown: Substring) -> String {

        // -- get the text component
        guard let text = markdown.content(delimitedBy: .squareBrackets) else { return html }

        // -- get the link component
        guard let link = markdown.content(delimitedBy: .parentheses) else { return html }

        // -- split into whitespace-separated tokens, ignoring empty strings
        let parts: [String] = link
            .components(separatedBy: CharacterSet.whitespaces)
            .filter { !$0.isEmpty }

        // -- the first token is always the image URL
        let imageUrl = parts[0]

        // -- scan remaining tokens for known flags
        var isZoomable = true
        var zoomSrc: String? = nil

        for token in parts.dropFirst() {
            if token.lowercased() == "nozoom" {
                isZoomable = false
            } else if token.lowercased().hasPrefix("zoomsrc=") {
                zoomSrc = String(token.dropFirst("zoomsrc=".count))
            }
        }

        // -- build the <img> node, conditionally adding data-zoom-src
        let imgNode: Node<HTML.BodyContext>
        if let zoomSrc = zoomSrc {
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

        // -- wrap in <figure> with optional <figcaption>
        let node: Node<HTML.BodyContext> = .figure(
            imgNode,
            .if(options.showCaption && !text.isEmpty, .figcaption(.text(String(text))))
        )

        return node.render()
    }
}
