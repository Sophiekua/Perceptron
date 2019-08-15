//
//  TrainingDataGenerator.swift
//  Perceptron
//
//  Created by Sophie Kua on 14/08/2019.
//  Copyright © 2019 Sophie Kua. All rights reserved.
//

import UIKit

class TrainingDataGenerator {
    var line: Line
    var numOfPoints: Int
    
    init(line: Line, numOfPoints: Int){
        self.line = line
        self.numOfPoints = numOfPoints
    }
    func generate() -> [PointAnswer] {
        var answers = [PointAnswer]()
        for _ in 0..<numOfPoints {
            let x = CGFloat.random(in: -100...100)
            let y = CGFloat.random(in: -100...100)
            let point = Point(x: x, y: y)
            let answer = calculatePointAnswer(point: point)
            answers.append(answer)
        }
        return answers
    }
    
    func calculatePointAnswer(point: Point) -> PointAnswer {
        let yLine = line.y(x: point.x)
        if point.y < yLine {
            return PointAnswer(point: point, isAbove: 1)
        } else{
            return PointAnswer(point: point, isAbove: 0)
        }
    }
}
struct PointAnswer {
    var point: Point
    var isAbove: Int
    
    init(point: Point, isAbove: Int){
        self.point = point
        self.isAbove = isAbove
    }
}
