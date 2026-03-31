# Image Zoom for Publish

Add a `medium.com` style image zoom for images within your Publish site.

Clicking an image expands it to fill the viewport. Scrolling dismisses it and animates it back into place.

![demo video](demo.gif)

## Installation

Add the package as a dependency in your `Package.swift`:

```swift
let package = Package(
    dependencies: [
        .package(
            url: "https://github.com/markbattistella/image-zoom-publish-plugin",
            from: "2.0.0"
        )
    ],
    targets: [
        .target(dependencies: ["ImageZoom"])
    ]
)
```

## Setup

### 1. Install the plugin

Add `.installPlugin(.zoomImage())` to your publishing pipeline:

```swift
import ImageZoom

try MyWebsite().publish(using: [
    .installPlugin(.zoomImage())
])
```

### 2. Add the script to your theme

Import `ImageZoom` and call `.zoomImageScripts()` once in your theme. It can go in `<head>` or at the end of `<body>` — the script loads with `defer` so it is non-blocking either way:

```swift
import ImageZoom

extension Node where Context == HTML.BodyContext {
    static func footer(for site: MyWebsite) -> Node {
        .footer(
            ...
            .zoomImageScripts()
        )
    }
}
```

That's it. When you build your site the plugin writes a single `zoom-image.js` to your output directory (the zoom library bundled with your configured options), and `.zoomImageScripts()` adds the `<script>` tag pointing to it.

## Configuration

Pass a `ZoomOptions` value to `.zoomImage()` to customise the behaviour. All parameters are optional and fall back to their defaults:

```swift
.installPlugin(.zoomImage(ZoomOptions(
    background: "var(--zoom-background)",
    margin: 24,
    scrollOffset: 40,
    showCaption: false
)))
```

| Option | Type | Default | Description |
| ------ | ---- | ------- | ----------- |
| `background` | `String` | `"#fff"` | Overlay colour behind the zoomed image. Accepts any CSS value. |
| `margin` | `Int` | `20` | Inset (in pixels) between the zoomed image and the viewport edges. |
| `scrollOffset` | `Int` | `40` | Pixels the user must scroll before the image dismisses. |
| `showCaption` | `Bool` | `true` | Render a `<figcaption>` below each image using its alt text. |

### Dark mode

Pass a CSS variable for `background` to respond to the user's colour scheme automatically:

```css
:root {
    --zoom-background: rgb(255, 255, 255);
}

@media (prefers-color-scheme: dark) {
    :root {
        --zoom-background: rgb(0, 0, 0);
    }
}
```

```swift
.installPlugin(.zoomImage(ZoomOptions(
    background: "var(--zoom-background)"
)))
```

## Usage

### Markdown

Images are zoomable by default — no changes to your existing markdown are needed:

```markdown
![My image](/my-awesome-image.jpg)
```

**Disable zoom on a specific image** using the `nozoom` flag (case-insensitive):

```markdown
![My image](/my-awesome-image.jpg nozoom)
```

**Specify a high-resolution zoom source** using the `zoomsrc=` flag. The thumbnail is shown inline; the full-res version loads on zoom:

```markdown
![My image](/thumbnail.jpg zoomsrc=/fullsize.jpg)
```

### Generated HTML

Each image is wrapped in a `<figure>` element. When `showCaption` is enabled (the default), a `<figcaption>` is rendered below it using the image's alt text:

```html
<figure>
    <img src="/my-awesome-image.jpg"
         alt="My image"
         title="My image"
         data-zoomable="true">
    <figcaption>My image</figcaption>
</figure>
```

Images with `nozoom` receive `data-zoomable="false"` and are excluded from the zoom behaviour. You can target both elements with CSS using the `figure` and `figcaption` selectors.

## Contributing

To contribute, create a Pull Request:

1. Clone the repo: `git clone https://github.com/markbattistella/image-zoom-publish-plugin.git`
1. Create your feature branch: `git checkout -b my-feature`
1. Commit your changes: `git commit -am 'Add some feature'`
1. Push to the branch: `git push origin my-feature`
1. Submit the pull request
