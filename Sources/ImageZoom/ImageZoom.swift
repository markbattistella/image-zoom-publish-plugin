//
//  Created by Mark Battistella
//	@markbattistella
//

import Ink
import Plot
import Files
import Publish


// MARK: - create the plugin
public extension Plugin {
    static func zoomImage(_ options: ZoomOptions = ZoomOptions()) -> Self {
        Plugin(name: "ImageZoom") { context in

            // -- write the library + auto-init as a single bundled file
            let jsFile = try context.createOutputFile(at: "zoom-image.js")
            try jsFile.write(zoomImageBundle(options))

            context.markdownParser.addModifier(
                .zoomImage(options: options)
            )
        }
    }
}

// MARK: - create the modifier
internal extension Modifier {
    static func zoomImage(options: ZoomOptions) -> Self {
        Modifier(target: .images) { html, markdown in
            return Builder()
                .zoom(options: options, html: html, markdown: markdown)
        }
    }
}

// MARK: - build the bundled JS output (library + init call)
private func zoomImageBundle(_ options: ZoomOptions) throws -> String {
    guard let library = try File(path: #filePath)
        .parent?
        .file(named: "Support/Utilities/zoom-image.js")
        .readAsString() else {
        throw ImageZoomError.missingLibraryFile
    }

    let initScript = """
    ;mediumZoom('[data-zoomable="true"]',{margin:\(options.margin),background:"\(options.background)",scrollOffset:\(options.scrollOffset)});
    """

    return library + initScript
}

// MARK: - errors
enum ImageZoomError: Error {
    case missingLibraryFile
}
