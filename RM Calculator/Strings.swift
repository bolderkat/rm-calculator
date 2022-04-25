//
//  Strings.swift
//  RM Calculator
//
//  Created by Daniel Luo on 4/22/22.
//

import Foundation

enum Strings {
    static let entryViewTitle = NSLocalizedString(
        "entryViewTitle",
        bundle: .main,
        value: "Edit Entry",
        comment: "Placeholder value for exercise entry field."
    )
    static let backButtonTitle = NSLocalizedString(
        "backButtonTitle",
        bundle: .main,
        value: "Back",
        comment: "Title for back button."
    )
    static let cancelButtonTitle = NSLocalizedString(
        "cancelButtonTitle",
        bundle: .main,
        value: "Cancel",
        comment: "Title for cancel button."
    )
    static let saveButtonTitle = NSLocalizedString(
        "saveButtonTitle",
        bundle: .main,
        value: "Save",
        comment: "Title for save button."
    )
    static let exerciseTextFieldPlaceholder = NSLocalizedString(
        "exerciseTextFieldPlaceholder",
        bundle: .main,
        value: "Ex: Squat, Deadlift, Bench",
        comment: "Placeholder value for exercise entry field."
    )
    static let repsTextFieldPlaceholder = NSLocalizedString(
        "repsTextFieldPlaceholder",
        bundle: .main,
        value: "Reps",
        comment: "Placeholder value for reps entry field."
    )
    static let weightTextFieldPlaceholder = NSLocalizedString(
        "weightTextFieldPlaceholder",
        bundle: .main,
        value: "Weight",
        comment: "Placeholder value for weight entry field."
    )
    static func repMaxLabel(with max: Int) -> String {
        let repMaxStringFormat = NSLocalizedString(
            "repMaxStringFormat",
            bundle: .main,
            value: "Your estimated 1RM: %i lb",
            comment: "Label for 1RM calculation result."
        )
        return String(format: repMaxStringFormat, max)
    }
}
