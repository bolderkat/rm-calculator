//
//  EntryScreen.swift
//  RM Calculator
//
//  Created by Daniel Luo on 4/21/22.
//


import WorkflowUI
import BlueprintUI
import BlueprintUICommonControls

struct EntryScreen: Screen {
    private enum Metrics {
        static let uniformInset: CGFloat = 24.0
    }
    
    let exercise: String
    let weightTextField: String
    let repsTextField: String
    let didUpdateExercise: (String) -> Void
    
    func element() -> Element {
        let column = Column { column in
            column.horizontalAlignment = .fill
            column.verticalUnderflow = .justifyToStart
            
            func addRow(_ element: Element) {
                column.add(child: element)
            }
            
            addRow(
                TextEntryBox(
                    placeholder: Strings.exerciseTextFieldPlaceholder,
                    entry: exercise,
                    didUpdateEntry: didUpdateExercise)
            )
        }
        
        let inset = Inset(
            uniformInset: Metrics.uniformInset,
            wrapping: column
        )
        
        var scrollView = ScrollView(wrapping: inset)
        scrollView.contentSize = .fittingHeight
        scrollView.alwaysBounceVertical = true
        return scrollView
    }
    
    
    func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
        EntryViewController.description(for: self, environment: environment)
    }
}

final class EntryViewController: ScreenViewController<EntryScreen> {
    override func loadView() {
        let blueprintView = BlueprintView(element: screen.element())
        self.view = blueprintView
    }
}
