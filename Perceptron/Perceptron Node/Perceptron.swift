//
//  Perceptron.swift
//  Perceptron
//
//  Created by Sophie Kua on 14/08/2019.
//  Copyright © 2019 Sophie Kua. All rights reserved.
//

import UIKit

class Perceptron {
    
    var weights: [CGFloat]
    var numberOfWeights: Int
    var bias: CGFloat = CGFloat.random(in: -1...1)
    
    init(numberOfWeights: Int) {
        self.numberOfWeights = numberOfWeights
        self.weights = [CGFloat]()
        for _ in 0..<numberOfWeights {
            let newWeight = CGFloat.random(in: -1...1)
            self.weights.append(newWeight)
        }
    }
    
    func processInputs(inputs: [CGFloat]) -> Int {
        let sum = sumWeightedInputs(inputs: inputs)
        let biased = biasedSum(sum: sum)
        let result = heavySideStepFunction(x: biased)
        return result
    }
    
    func sumWeightedInputs(inputs: [CGFloat]) -> CGFloat {
        var sum: CGFloat = 0
        for i in 0..<numberOfWeights {
            sum = sum + inputs[i] * weights[i]
        }
        return sum
    }
    
    func biasedSum(sum: CGFloat) -> CGFloat{
        return sum + bias
    }
    
    func heavySideStepFunction(x: CGFloat) -> Int{
        if x < 0 {
            return 0
        } else {
            return 1
        }
    }
    
    
}
