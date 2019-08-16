//
//  Line.swift
//  Perceptron
//
//  Created by Sophie Kua on 14/08/2019.
//  Copyright © 2019 Sophie Kua. All rights reserved.
//

import UIKit

class Line {
    let gradient: CGFloat
    let yIntercept: CGFloat
    
    init(gradient: CGFloat, yIntercept: CGFloat){
        self.gradient = gradient
        self.yIntercept = yIntercept
    }

    func y(x:CGFloat) -> CGFloat {
        let y = gradient * x + yIntercept
        return y
    }
}
