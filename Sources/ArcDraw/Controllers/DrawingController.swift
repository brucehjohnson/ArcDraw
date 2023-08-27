import SwiftUI
import CoreGraphics

class DrawingController: ObservableObject {
  @Published var lines: [Line] = []

  init(picdef: PictureDefinition) {
    populateLinesFromPicdef(picdef: picdef)
  }

  func populateLinesFromPicdef(picdef: PictureDefinition) {
    // Clear existing lines
    lines.removeAll()

    // Convert each arc in picdef to a series of connected lines
    for arc in picdef.curveData {

      // TODO BHJ: switch to read function when ready
      //let arcPoints = generatePointsForArc(arc)
      let arcPoints = generateDummyPointsForArc(arc)

      // Create lines connecting each pair of adjacent points
      for i in 0..<(arcPoints.count - 1) {
        let startPoint = arcPoints[i]
        let endPoint = arcPoints[i + 1]
        lines.append(Line(points: [startPoint, endPoint]))
      }
    }
  }

  func generatePointsForArc(_ arc: CurveData) -> [CGPoint] {
    /*
     This is where the arcdraw magic happens
     each arc has this data:

     var name: String
     var description: String
     var dotLocations: [CGPoint]
     var startAngle: Double
     var endAngle: Double
     var isClockwise: Bool
     */
    print("Calculating points for arc data \(arc).")
      return []
  }

  func generateDummyPointsForArc(_ arc: CurveData) -> [CGPoint] {
    /*
     This is a temporary function until ArcDraw is implemented.
     Each arc has this data:
     - var name: String
     - var description: String
     - var dotLocations: [CGPoint]
     - var startAngle: Double
     - var endAngle: Double
     - var isClockwise: Bool
     */

    print("Calculating points for arc data \(arc).")

    // Placeholder: Generate some dummy points to represent dots or a line
    var points: [CGPoint] = []

    // For demonstration purposes, let's draw a line connecting all dotLocations
    if !arc.dotLocations.isEmpty {
      let firstPoint = arc.dotLocations[0]
      points.append(firstPoint)

      for i in 1..<arc.dotLocations.count {
        let currentPoint = arc.dotLocations[i]
        points.append(currentPoint)
      }
    }

    // Uncomment the following line if you want to return just the dots
    return arc.dotLocations

    // Return the points representing dots and/or the line connecting them
    //return points
  }





  func addPoint(_ point: CGPoint) {
    if var lastLine = lines.popLast() {
      lastLine.points.append(point)
      lines.append(lastLine)
    } else {
      lines.append(Line(points: [point]))
    }
  }

  func startNewLine() {
    lines.append(Line(points: []))
  }
}
