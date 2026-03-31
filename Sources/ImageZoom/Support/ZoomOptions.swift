//
//  Created by Mark Battistella
//	@markbattistella
//

import Foundation

/// Configuration options for the image zoom behaviour.
public struct ZoomOptions {

    /// The background colour of the overlay shown behind the zoomed image.
    /// Accepts any valid CSS colour value: hex (`"#fff"`), rgba (`"rgba(0,0,0,0.9)"`),
    /// or a CSS variable (`"var(--background-colour)"`).
    public var background: String

    /// The inset margin (in pixels) between the zoomed image and the viewport edges.
    public var margin: Int

    /// The number of pixels the user must scroll before the zoomed image is dismissed.
    public var scrollOffset: Int

    /// Whether to render a `<figcaption>` element below each image using its alt text.
    public var showCaption: Bool

    public init(
        background: String = "#fff",
        margin: Int = 20,
        scrollOffset: Int = 40,
        showCaption: Bool = true
    ) {
        self.background = background
        self.margin = margin
        self.scrollOffset = scrollOffset
        self.showCaption = showCaption
    }
}
