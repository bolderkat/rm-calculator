//
//  RepWeightRow.swift
//  RM Calculator
//
//  Created by Daniel Luo on 4/22/22.
//

import BlueprintUI
import BlueprintUICommonControls

struct RepWeightRow: ProxyElement {
    let repsTextField: String
    let weightTextField: String
    let didUpdateReps: (String) -> Void
    let didUpdateWeight: (String) -> Void
    
    var elementRepresentation: Element {
        Row { row in
            row.verticalAlignment = .fill
            row.horizontalUnderflow = .justifyToStart
            row.minimumHorizontalSpacing = 24.0
            
            func addColumn(_ element: Element) {
                row.add(child: element)
            }
            
            addColumn(
                NumericEntryBox(
                    placeholder: Strings.repsTextFieldPlaceholder,
                    entry: repsTextField,
                    didUpdateEntry: didUpdateReps
                )
            )
            
            addColumn(Label(text: "X"))
            
            addColumn(
                NumericEntryBox(
                    placeholder: Strings.weightTextFieldPlaceholder,
                    entry: weightTextField,
                    didUpdateEntry: didUpdateWeight
                )
            )
        }
    }
}

