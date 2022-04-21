import UIKit

/// Aligns a content element within itself. The vertical and horizontal alignment may be set independently.
///
/// When using alignment mode `.fill`, the content is scaled to the width or height of the `Aligned` element.
///
/// For other modes, the size of the content element is determined by calling `measure(in:)`
/// on the content element – even if that size is larger than the wrapping element.
///
public struct Aligned: Element {
    /// The possible vertical alignment values.
    public enum VerticalAlignment {
        /// Aligns the content to the top edge of the containing element.
        case top
        /// Centers the content vertically.
        case center
        /// Aligns the content to the bottom edge of the containing element.
        case bottom
        /// The content fills the full vertical height of the containing element.
        case fill
    }

    /// The possible horizontal alignment values.
    public enum HorizontalAlignment {
        /// Aligns the content to the leading edge of the containing element.
        /// In left-to-right languages, this is the left edge.
        case leading
        /// Centers the content horizontally.
        case center
        /// Aligns the content to the trailing edge of the containing element.
        /// In left-to-right languages, this is the right edge.
        case trailing
        /// The content fills the full horizontal width of the containing element.
        case fill
    }

    /// The content element to be aligned.
    public var wrappedElement: Element
    /// The vertical alignment.
    public var verticalAlignment: VerticalAlignment
    /// The horizontal alignment.
    public var horizontalAlignment: HorizontalAlignment

    /// Initializes an `Aligned` with the given content element and alignments.
    ///
    /// - parameters:
    ///   - vertically: The vertical alignment. Defaults to centered.
    ///   - horizontally: The horizontal alignment. Defaults to centered.
    ///   - wrapping: The content element to be aligned.
    public init(
        vertically verticalAlignment: VerticalAlignment = .center,
        horizontally horizontalAlignment: HorizontalAlignment = .center,
        wrapping wrappedElement: Element
    ) {
        self.verticalAlignment = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.wrappedElement = wrappedElement
    }

    public var content: ElementContent {
        let layout = Layout(verticalAlignment: verticalAlignment, horizontalAlignment: horizontalAlignment)
        return ElementContent(child: wrappedElement, layout: layout)
    }

    public func backingViewDescription(with context: ViewDescriptionContext) -> ViewDescription? {
        nil
    }

    private struct Layout: SingleChildLayout {
        var verticalAlignment: VerticalAlignment
        var horizontalAlignment: HorizontalAlignment

        func measure(in constraint: SizeConstraint, child: Measurable) -> CGSize {
            child.measure(in: constraint)
        }

        func layout(size: CGSize, child: Measurable) -> LayoutAttributes {
            let contentSize = child.measure(in: SizeConstraint(size))

            var attributes = LayoutAttributes(size: contentSize)

            switch verticalAlignment {
            case .top:
                attributes.frame.origin.y = 0
            case .center:
                attributes.frame.origin.y = (size.height - contentSize.height) / 2.0
            case .bottom:
                attributes.frame.origin.y = size.height - contentSize.height
            case .fill:
                attributes.frame.origin.y = 0
                attributes.frame.size.height = size.height
            }

            switch horizontalAlignment {
            case .leading:
                attributes.frame.origin.x = 0
            case .center:
                attributes.frame.origin.x = (size.width - contentSize.width) / 2.0
            case .trailing:
                attributes.frame.origin.x = size.width - contentSize.width
            case .fill:
                attributes.frame.origin.x = 0
                attributes.frame.size.width = size.width
            }

            return attributes
        }
    }
}

extension Element {
    /// Wraps the element in an `Aligned` element with the provided parameters.
    ///
    /// - parameters:
    ///   - vertically: The vertical alignment. Defaults to `.centered`.
    ///   - horizontally: The horizontal alignment. Defaults to `.centered`.
    ///
    public func aligned(
        vertically: Aligned.VerticalAlignment = .center,
        horizontally: Aligned.HorizontalAlignment = .center
    ) -> Aligned {
        Aligned(
            vertically: vertically,
            horizontally: horizontally,
            wrapping: self
        )
    }
}
