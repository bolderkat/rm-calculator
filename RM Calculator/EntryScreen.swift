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
    
    let exercise: String
    let weightTextField: String
    let repsTextField: String
    let didUpdateExercise: (String) -> Void
    
    func element() -> Element {
        Column { column in
            column.horizontalAlignment = .fill
            column.verticalUnderflow = .justifyToStart
            
            func addRow(_ element: Element) {
                column.add(child: element)
            }
            
            addRow(
                TextEntryBox(
                    placeholder: "Ex: Squat, Deadlift, Bench...",
                    entry: exercise,
                    didUpdateEntry: didUpdateExercise)
            )
        }.inset(top: 20, bottom: 20, left: 20, right: 20)
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
