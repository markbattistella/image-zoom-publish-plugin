//
//  markbattistella.com
//  Created by Mark Battistella
//

import Plot
import Foundation

extension Node where Context: HTML.BodyContext {

    /// Creates a `<figure>` element containing the given child nodes.
    ///
    /// - Parameter nodes: The child nodes to nest inside the figure.
    static func figure(_ nodes: Node<Context>...) -> Node {
        .element(named: "figure", nodes: nodes)
    }

    /// Creates a `<figcaption>` element containing the given child nodes.
    ///
    /// - Parameter nodes: The child nodes to nest inside the figcaption.
    static func figcaption(_ nodes: Node<Context>...) -> Node {
        .element(named: "figcaption", nodes: nodes)
    }
}
