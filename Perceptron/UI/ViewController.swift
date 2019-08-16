//
//  ViewController.swift
//  PerceptronBrain
//
//  Created by Keith Dev on 14/08/2019.
//  Copyright © 2019 Founders4Schools. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lineGradient: UITextField!
    @IBOutlet weak var lineYIntercept: UITextField!
    @IBOutlet weak var graphView: GraphView!
    let numberToolbar: UIToolbar = UIToolbar()
    
    var perceptron = Perceptron(numberOfWeights: 2)
    var line: Line = Line(gradient: 0, yIntercept: 0)
    var points: [Point] = []
    
    // Train the perceptron to understand what points are above and below the line
    @IBAction func trainPerceptron(_ sender: Any) {
        perceptron = Perceptron(numberOfWeights: 2)
        generateLineFromUserInput()
        let teacher = Teacher(line: line, perceptron: perceptron)
        teacher.train()
        displayGraph()
    }
    
    // Uses the gradient angle and intercept values the user has entered to create
    // a new line
    func generateLineFromUserInput() {
        let gradientDegrees = Float(lineGradient?.text ?? "0") ?? 0.0
        let gradient = CGFloat(tan(gradientDegrees*Float.pi/180.0))
        let yIntercept = CGFloat(Float(lineYIntercept?.text ?? "0") ?? Float(0))
        line = Line(gradient: gradient, yIntercept: yIntercept)
    }
    
    // Tests the perceptron's understanding of what is above and below the line
    @IBAction func testPerceptron(_ sender: Any) {
        var testPoints: [Point] = []
        for _ in 0..<50 {
            let testPoint = Point(x: CGFloat.random(in: -100...100), y: CGFloat.random(in: -100...100))
            testPoints.append(testPoint)
        }
        graphView.points = testPoints
    }
    
    func displayGraph() {
        graphView.perceptron = perceptron
        graphView.line = line
        graphView.points = points
    }
    
    override func viewDidLoad() {
        setupNumberpad()
        generateLineFromUserInput()
        displayGraph()
    }
}


// MARK:- User interface helpers
extension ViewController {
    // One-time only configuration of the number pad used to enter numbers
    func setupNumberpad() {
        numberToolbar.barStyle = .default
        numberToolbar.items=[
            UIBarButtonItem(title: "+/-", style: .plain, target: self, action: #selector(toggleMinus)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneKeyboard))
        ]
        numberToolbar.sizeToFit()
        lineGradient.inputAccessoryView = numberToolbar
        lineYIntercept.inputAccessoryView = numberToolbar
    }
    
    // dismiss the number pad when the done button is tapped
    @objc func doneKeyboard(sender: UIBarButtonItem) {
        if lineGradient.isFirstResponder { lineGradient.resignFirstResponder() }
        if lineYIntercept.isFirstResponder { lineYIntercept.resignFirstResponder() }
        generateLineFromUserInput()
        displayGraph()
    }
    
    // Toggles between positive and negative values for numbers entered using the number pad
    @objc func toggleMinus(){
        guard let textField = lineGradient.isFirstResponder ? lineGradient : lineYIntercept else { return}
        if var text = textField.text , text.isEmpty == false{
            if text.hasPrefix("-") {
                text = text.replacingOccurrences(of: "-", with: "")
            } else {
                text = "-\(text)"
            }
            textField.text = text
        }
    }
}

