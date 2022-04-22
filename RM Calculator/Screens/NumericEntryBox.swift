//
//  NumericEntryBox.swift
//  RM Calculator
//
//  Created by Daniel Luo on 4/22/22.
//

import BlueprintUI
import BlueprintUICommonControls

struct NumericEntryBox: ProxyElement {
    private enum Metrics {
        static let inset: UIEdgeInsets = .init(
            top: 0.0,
            left: 10.0,
            bottom: 0.0,
            right: 0.0
        )
        static let outlineCornerRadius: CGFloat = 10.0
        static let outlineWidth: CGFloat = 0.5
    }
    
    var placeholder: String
    var entry: String
    var didUpdateEntry: (String) -> Void
    
    var elementRepresentation: Element {
        TextField(text: entry) { textField in
            textField.placeholder = placeholder
            textField.enablesReturnKeyAutomatically = true
            textField.keyboardType = .numberPad
            textField.onChange = didUpdateEntry
        }
        .inset(by: Metrics.inset)
        .box(
            background: .clear,
            corners: .rounded(
                radius: Metrics.outlineCornerRadius,
                corners: .all
            ),
            cornerCurve: .circular,
            borders: .solid(
                color: .lightGray,
                width: Metrics.outlineWidth
            ),
            shadow: .none,
            clipsContent: false
        )
    }
}
