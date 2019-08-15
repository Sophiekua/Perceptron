
import UIKit

// Draws a graph including horizontal and vertical axes, the straight line, and
// a set of points. We ask our perceptron whether it thinks the point is above
// or below the line, and color the point accordingly
class GraphView: UIView {
    
    //The star of the show! The perceptron is our AI's brain
    var perceptron: Perceptron = Perceptron(numberOfWeights: 2)
    
    // The color to be used when drawing the axes of the graph
    let axesColor = UIColor.init(white: 0.7, alpha: 1).cgColor
    
    // The color to be used when drawing the straight line
    let lineColor = UIColor(red: 0, green: 0.7, blue: 0.1, alpha: 0.7).cgColor
    
    // The color to be used for a point when our perceptron thinks the point is
    // above the line (this is a red-ish color)
    let aboveColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1).cgColor
    
    // The color to be used for a point when our perceptron thinks the point is
    // below the line (this is a blue-ish color)
    let belowColor = UIColor(red: 0, green: 0.1, blue: 0.7, alpha: 1).cgColor
    
    // The straight line. We generate points randomly and use our perceptron
    // to decide whether each of the points is above or below the line
    var line: Line = Line(gradient: 1, yIntercept: 10) {
        didSet {
            // If we set a new line we want to redraw the graph
            setNeedsDisplay()
        }
    }
    
    // The array of points we want our perceptron to think about
    var points: [Point] = [] {
        didSet {
            // If we set a new array of points then we redraw the graph
            setNeedsDisplay()
        }
    }
    
    // Do not call this explicitly. iOS will call this function whenever we tell
    // it that the graph needs to be updated
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.scaleBy(x: bounds.width/200, y: -bounds.height/200)
        ctx.translateBy(x: 100, y: -100)
        drawAxes(into: ctx)
        drawPoints(points, into: ctx)
        drawLine(self.line, into: ctx)
    }
    
    // Draws the axes of the graph
    func drawAxes(into ctx: CGContext) {
        ctx.setLineWidth(1)
        ctx.setStrokeColor(axesColor)
        let xAxis1 = CGPoint(x: -100, y: 0)
        let xAxis2 = CGPoint(x: 100, y: 0)
        let yAxis1 = CGPoint(x: 0, y: -100)
        let yAxis2 = CGPoint(x: 0, y: 100)
        ctx.strokeLineSegments(between: [xAxis1, xAxis2])
        ctx.strokeLineSegments(between: [yAxis1, yAxis2])
    }
    
    // Draws the straight line on the graph
    func drawLine(_ line: Line, into ctx: CGContext) {
        ctx.setLineWidth(2)
        ctx.setStrokeColor(lineColor)
        let pt1 = CGPoint(x: -100, y: line.y(x: -100))
        let pt2 = CGPoint(x: 100, y: line.y(x: 100))
        ctx.strokeLineSegments(between: [pt1,pt2])
    }
    
    // Draws the points on the graph. For each point, ask our AI brain whether it
    // thinks the point is above or below the line, and sets the point color
    // accordingly
    func drawPoints(_ points: [Point], into ctx: CGContext) {
        for point in points {
            let isAboveLine = askPerceptronIfPointIsAboveLine(point: point)
            let color = isAboveLine ? aboveColor : belowColor
            ctx.setLineWidth(0.0)
            ctx.setFillColor(color)
            ctx.setStrokeColor(UIColor.lightGray.cgColor)
            let rect = CGRect(x: point.x - 5, y: point.y - 5, width: 10, height: 10)
            ctx.fillEllipse(in: rect)
        }
    }
    
    // This is how we ask our perceptron about the position of the point relative
    // to the line. We convert the perceptron's answer from an Int to a Bool
    func askPerceptronIfPointIsAboveLine(point: Point) -> Bool {
        let output = perceptron.processInputs(inputs: [point.x, point.y])
        if output == 1 { return true }
        return false
    }
}
