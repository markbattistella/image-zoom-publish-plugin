//
//  markbattistella.com
//  Created by Mark Battistella
//

import Ink
import Plot
import Files
import Publish

// MARK: - Plugin

public extension Plugin {

    /// Creates a Publish plugin that adds medium-zoom image behaviour to your site.
    ///
    /// The plugin does two things at build time:
    /// 1. Writes a bundled `zoom-image.js` file (medium-zoom library + init call) to your output.
    /// 2. Registers a markdown modifier that wraps images in `<figure>` elements with
    ///    `data-zoomable` attributes consumed by the script.
    ///
    /// Add it to your `PublishingStep` pipeline:
    ///
    /// ```swift
    /// try Website.publish(using: [
    ///     .installPlugin(.zoomImage()),
    ///     ...
    /// ])
    /// ```
    ///
    /// - Parameter options: Zoom behaviour configuration. Defaults to ``ZoomOptions/init()``.
    /// - Returns: A configured `Plugin` instance.
    static func zoomImage(_ options: ZoomOptions = ZoomOptions()) -> Self {
        Plugin(name: "ImageZoom") { context in
            let jsFile = try context.createOutputFile(at: "zoom-image.js")
            try jsFile.write(zoomImageBundle(options))
            context.markdownParser.addModifier(.zoomImage(options: options))
        }
    }
}

// MARK: - Modifier

internal extension Modifier {

    /// Registers an Ink modifier that replaces image markdown with zoomable figure HTML.
    static func zoomImage(options: ZoomOptions) -> Self {
        Modifier(target: .images) { html, markdown in
            Builder().zoom(options: options, html: html, markdown: markdown)
        }
    }
}

// MARK: - JS Bundle

/// Concatenates the bundled medium-zoom library with a site-specific initialisation call.
///
/// - Parameter options: The zoom options used to configure the `mediumZoom(...)` call.
/// - Throws: ``ImageZoomError/missingLibraryFile`` if the bundled JS cannot be located.
/// - Returns: A single JS string ready to be written to the output folder.
private func zoomImageBundle(_ options: ZoomOptions) throws -> String {
    guard let library = try File(path: #filePath)
        .parent?
        .file(named: "Support/Utilities/zoom-image.js")
        .readAsString() else {
        throw ImageZoomError.missingLibraryFile
    }

    let initScript = ";mediumZoom('[data-zoomable=\"true\"]',{margin:\(options.margin),background:\"\(options.background)\",scrollOffset:\(options.scrollOffset)});"

    return library + initScript
}

// MARK: - Errors

/// Errors that can be thrown by the ImageZoom plugin.
public enum ImageZoomError: Error {

    /// The bundled `zoom-image.js` file could not be found relative to the plugin source.
    case missingLibraryFile
}
