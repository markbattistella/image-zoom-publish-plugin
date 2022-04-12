# Image Zoom for Publish

Add a Medium.com style image zoom for items within the document content.

The script allows images to be zoomed to the full width of the view port so the user can expand images beyond the container width.

It also allows users to continue scrolling and allowing it to automatically resign into its original placment.

![demo video](demo.gif)

## Installation

To install it into your Publish package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
  dependencies: [
    .package(name: "ImageZoom", url: "https://github.com/markbattistella/image-zoom-publish-plugin", from: "1.0.0")
  ],
  targets: [
    .target(
      dependencies: [
        "ImageZoom"
	  ]
	)
  ]
)
```

You will then need to call the javascript file from your footer, or at least anywhere **after** your markdown body.

The best way to inject the script is to add it to your `.footer` element:

```swift
extension Node where Context == HTML.BodyContext {
  static func footer<T: Website>(for site: T) -> Node {
    return .footer(
	  // insert your own footer items here
      .raw("<script src='/assets/js/zoomImage.js'></script>")
    )
  }
}
```

## Usage

### Pipeline

The plugin can then be used within any publishing pipeline like this:

```swift
import ImageZoom

try DeliciousRecipes().publish(using: [
  .installPlugin(.zoomImage())
])
```

By default it will hide the image captions, however if you wish to show them under the image do so by installing the plugin as:

```swift
import ExtraComponents

try DeliciousRecipes().publish(using: [
  .installPlugin(.zoomImage(showCaption: true))
])
```

### Markdown

When writing your markdown documents you add an image as you normally would. This will automatically be transformed into accepting the zooming attributes.

```markdown
![My image](/my-awesome-image.jpg)
```

If you want to disable the zooming on a specific image add the `noZoom` attribute after the image url:

```markdown
![My image - this wont zoom](/my-awesome-image.jpg noZoom)
```

## Contributing

I have a very basic knowledge on the world of Swift, and particularly outisde iOS.

For this, I've turned off Issues and if you wish to add/change the codebase please create a Pull Request.

This way everyone can allow these components to grow, and be the best rather than waiting on me to write it.

### How to help

1. Clone the repo: `git clone https://github.com/markbattistella/image-zoom-publish-plugin.git`
1. Create your feature branch: `git checkout -b my-feature`
1. Commit your changes: `git commit -am 'Add some feature'`
1. Push to the branch: `git push origin my-new-feature`
1. Submit the pull request
