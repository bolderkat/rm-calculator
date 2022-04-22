//
//  EntryWorkflow.swift
//  RM Calculator
//
//  Created by Daniel Luo on 4/21/22.
//

import Foundation
import Workflow

struct EntryWorkflow: Workflow {
    // MARK: Input
    // Add, if any
    
    // MARK: Output
    enum Output: Equatable {
        case didCancel
        case didSaveEntry(Entry)
    }
}

// MARK: State
extension EntryWorkflow {
    struct State: Equatable {
        var exercise: String
        var repsTextField: String
        var reps: Int? {
            Int(repsTextField)
        }
        var weightTextField: String
        var weight: Int? {
            Int(weightTextField)
        }
        var presentingScreen: PresentingScreen
        
        enum PresentingScreen: Equatable {
            case none
            case validationErrorModal(ValidationError)
            case overwriteConfirmation
        }
        
        enum ValidationError: Equatable {
            case invalidEntry
        }
    }
    
    func makeInitialState() -> State {
        State(
            exercise: "",
            repsTextField: "",
            weightTextField: "",
            presentingScreen: .none
        )
    }
}

// MARK: Actions
extension EntryWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = EntryWorkflow
        
        case didTapCancel
        case didTapSave
        case didEditExercise(String)
        case didEditWeight(String)
        case didEditReps(String)
        case didDismissValidationError
        case didCancelOverwrite
        case didAcceptOverwrite
        
        func apply(toState state: inout State) -> Output? {
            func createNewEntry() -> Entry? {
                guard
                    let weight = state.weight,
                    let reps = state.reps,
                    !state.exercise.trimmingCharacters(in: .whitespaces).isEmpty,
                    weight > 0,
                    reps > 0 else {
                        // Input is invalid.
                        return nil
                    }
                return Entry(
                    exercise: state.exercise,
                    weight: weight,
                    reps: reps,
                    dateCreated: .now
                )
            }
            
            switch self {
            case .didTapCancel:
                return .didCancel
            case .didTapSave:
                guard let entry = createNewEntry() else {
                    state.presentingScreen = .validationErrorModal(.invalidEntry)
                    return nil
                }
                return .didSaveEntry(entry)
            case .didEditExercise(let exercise):
                state.exercise = exercise
            case .didEditWeight(let weight):
                state.weightTextField = weight
            case .didEditReps(let reps):
                state.repsTextField = reps
            case .didDismissValidationError:
                state.presentingScreen = .none
            case .didCancelOverwrite:
                state.presentingScreen = .none
            case .didAcceptOverwrite:
                state.presentingScreen = .none
                // TODO: overwrite old entry with parent
                break
            }
            return nil
        }
    }
}

// MARK: Rendering
extension EntryWorkflow {
    typealias Rendering = EntryScreen
    
    func render(state: State, context: RenderContext<EntryWorkflow>) -> Rendering {
        let sink = context.makeSink(of: Action.self)
        return EntryScreen(
            exercise: state.exercise,
            repsTextField: state.repsTextField,
            weightTextField: state.weightTextField,
            didUpdateExercise: { exercise in
                sink.send(.didEditExercise(exercise))
            },
            didUpdateReps: { reps in
                sink.send(.didEditReps(reps))
            },
            didUpdateWeight: { weight in
                sink.send(.didEditWeight(weight))
            }
        )
    }
}
