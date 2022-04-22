//
//  TextEntryBox.swift
//  RM Calculator
//
//  Created by Daniel Luo on 4/21/22.
//

import BlueprintUI
import BlueprintUICommonControls

struct TextEntryBox: ProxyElement {
    var placeholder: String
    var entry: String
    var didUpdateEntry: (String) -> Void
    
    var elementRepresentation: Element {
        TextField(text: entry) { textField in
            textField.placeholder = placeholder
            textField.enablesReturnKeyAutomatically = true
            textField.clearButtonMode = .whileEditing
            textField.onChange = didUpdateEntry
        }
    }
}
