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
        static let columnSpacing: CGFloat = 16.0
    }
    
    let exercise: String
    let repsTextField: String
    let weightTextField: String
    let calculated1RM: Int?
    let didUpdateExercise: (String) -> Void
    let didUpdateReps: (String) -> Void
    let didUpdateWeight: (String) -> Void
    
    private var maxString: String {
        guard let max = calculated1RM else { return "" }
        return Strings.repMaxLabel(with: max)
    }
    
    func element() -> Element {
        let column = Column { column in
            column.horizontalAlignment = .fill
            column.verticalUnderflow = .justifyToStart
            column.minimumVerticalSpacing = Metrics.columnSpacing
            
            func addRow(_ element: Element) {
                column.add(child: element)
            }
            
            addRow(
                TextEntryBox(
                    placeholder: Strings.exerciseTextFieldPlaceholder,
                    entry: exercise,
                    didUpdateEntry: didUpdateExercise)
            )
            
            addRow(
                RepWeightRow(
                    repsTextField: repsTextField,
                    weightTextField: weightTextField,
                    didUpdateReps: didUpdateReps,
                    didUpdateWeight: didUpdateWeight)
            )
            
            addRow(Centered(Label(text: maxString)))
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
    let blueprintView = BlueprintView(element: nil)

    override func loadView() {
        blueprintView.element = screen.element()
        self.view = blueprintView
    }
    
    override func screenDidChange(from previousScreen: EntryScreen, previousEnvironment: ViewEnvironment) {
        blueprintView.element = screen.element()
    }
}
