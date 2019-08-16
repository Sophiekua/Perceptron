//
//  Teacher.swift
//  Perceptron
//
//  Created by Sophie Kua on 14/08/2019.
//  Copyright © 2019 Sophie Kua. All rights reserved.
//

import UIKit

class Teacher {
    let learningRate: CGFloat = 0.1
    let line: Line
    let perceptron: Perceptron
    
    init(line:Line, perceptron: Perceptron){
        self.line = line
        self.perceptron = perceptron
    }
    func train(){
        let trainingGenerator: TrainingDataGenerator = TrainingDataGenerator(line: line, numOfPoints: 10000)
        
        let answers = trainingGenerator.generate()
        for answer in answers {
            let x = answer.point.x
            let y = answer.point.y
            let perceptronAnswer = perceptron.processInputs(inputs: [x,y])
            let difference = answer.isAbove - perceptronAnswer
            adjustPerceptron(perceptron: perceptron, inputs: [x,y], difference: difference)
        }
        
    }
    func adjustPerceptron(perceptron:Perceptron, inputs: [CGFloat], difference: Int ) {
        if difference == 0 { return }
        let adjustmentFactor = CGFloat(difference) * learningRate
        perceptron.bias = perceptron.bias + adjustmentFactor
        for i in 0..<perceptron.numberOfWeights{
            perceptron.weights[i] = perceptron.weights[i] + inputs[i] * adjustmentFactor
        }
    }
    
}
