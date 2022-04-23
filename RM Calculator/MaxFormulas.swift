//
//  MaxFormulas.swift
//  RM Calculator
//
//  Created by Daniel Luo on 4/22/22.
//

import Foundation

enum MaxFormulas {
    static let epley: (Int?, Int?) -> Int? = { reps, weight in
        guard let reps = reps,
              let weight = weight else {
                  return nil
              }
        guard reps > 1 else {
            return weight
        }
        let result = Double(weight) * (1.0 + (Double(reps) / 30.0))
        return Int(result.rounded())
    }
    
    static let brzycki: (Int?, Int?) -> Int? = { reps, weight in
        guard let reps = reps,
              let weight = weight else {
                  return nil
              }
        guard reps > 1 else {
            return weight
        }
        let result = Double(weight) * 36.0 / (37.0 - Double(reps))
        return Int(result.rounded())
    }
}
