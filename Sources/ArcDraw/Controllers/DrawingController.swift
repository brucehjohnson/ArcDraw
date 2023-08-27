import SwiftUI

class DrawingController: ObservableObject {
  @Published var lines: [Line] = []

  init(picdef: PictureDefinition) {
    populateDotsFromPicdef(picdef: picdef)
  }

  func populateDotsFromPicdef(picdef: PictureDefinition) {
    // Clear existing lines
    lines.removeAll()

    for arc in picdef.arcDefinitions {
      // Draw the points for each dot in the arcDefinition
      var points: [CGPoint] = []
      for pointDict in arc.dotLocations {
        if let x = pointDict["x"], let y = pointDict["y"] {
          let point = CGPoint(x: x, y: y)
          points.append(point)
        }
      }
      // Create a new line for the collected points
      lines.append(Line(points: points))
    }
  }

  func populateLinesFromPicdef(picdef: PictureDefinition) {
    // Clear existing lines
    lines.removeAll()

    // Convert each arc in picdef to a series of connected lines
    for arc in picdef.arcDefinitions {

      // TODO BHJ: switch to read function when ready
      // let arcPoints = generatePointsForArc(arc)
      let arcPoints = generateDummyPointsForArc(arc)

      // Create lines connecting each pair of adjacent points
      for i in 0..<(arcPoints.count - 1) {
        let startPoint = arcPoints[i]
        let endPoint = arcPoints[i + 1]
        lines.append(Line(points: [startPoint, endPoint]))
      }
    }
  }

  func generatePointsForArc(_ arc: ArcDefinition) -> [CGPoint] {
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

  func generateDummyPointsForArc(_ arc: ArcDefinition) -> [CGPoint] {

    print("Calculating dummy points for arc data \(arc).")

    // Placeholder: Generate some dummy points to represent dots
    var points: [CGPoint] = []

    // For demonstration purposes, let's use the dotLocations directly
    for pointDict in arc.dotLocations {
      if let x = pointDict["x"], let y = pointDict["y"] {
        let point = CGPoint(x: x, y: y)
        points.append(point)
      }
    }

    return points
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
