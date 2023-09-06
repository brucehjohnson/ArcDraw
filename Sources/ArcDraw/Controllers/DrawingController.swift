import SwiftUI

class DrawingController: ObservableObject {
  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String
  @Published var lines: [Line] = []

  init(doc: ArcDrawDocument, selectedExample: Binding<String>) {
    self.doc = doc
    self._selectedExample = selectedExample
  }

  func updateDrawing(for example: String) {
    print("Updating drawing for \(example)")
    populateDotsFromPicdef(picdef: doc.picdef)
    self.objectWillChange.send() // Force the update announcement
  }

  func getCGPointsForCurve(curves: CurveDefinition) -> [CGPoint] {
    var points: [CGPoint] = []

    for dot in curves.dots {
      let xString = dot.x
      let yString = dot.y
      let xInteger = getIntFromPossibleSumString(dataString: xString)
      let yInteger = getIntFromPossibleSumString(dataString: yString)
      let point = CGPoint(x: xInteger!, y: yInteger!)
      points.append(point)
    }

    return points
  }

  func populateDotsFromPicdef(picdef: PictureDefinition) {
    print("populating dots from picdef \(picdef.curves.count) curves")
    // Clear existing lines
    lines.removeAll()

    for curve in picdef.curves {
      var points: [CGPoint] = getCGPointsForCurve(curves: curve)
      for point in points {
            points.append(point)
        }
      lines.append(Line(points: points))
      }
    }

  func populateLinesFromPicdef(picdef: PictureDefinition) {
    // Clear existing lines
    lines.removeAll()

    // Convert each curve in picdef to a series of connected lines
    for curve in picdef.curves {

      // TODO BHJ: switch to read function when ready
      // let arcPoints = generatePointsForArc(curve)
      let arcPoints = generateDummyPointsForArc(curve)

      // Create lines connecting each pair of adjacent points
      for i in 0..<(arcPoints.count - 1) {
        let startPoint = arcPoints[i]
        let endPoint = arcPoints[i + 1]
        lines.append(Line(points: [startPoint, endPoint]))
      }
    }
  }

  func generatePointsForCurve(_ curve: CurveDefinition) -> [CGPoint] {
    /*
     This is where the arcdraw magic happens
   */
    print("Calculating points for curve \(curve).")
      return []
  }

  func getIntFromPossibleSumString(dataString: String) -> Int? {
    // Split x or y string by '+' character
    let components = dataString.split(separator: "+")

    if components.count == 1 {
      // If there's no '+', just convert string to integer
      return Int(components[0])
    } else if components.count == 2 {
      // If there's a '+', convert components to integers and sum
      if let firstInt = Int(components[0]), let secondInt = Int(components[1]) {
        return firstInt + secondInt
      }
    }
    // Return nil if can't convert or sum the components
    return nil
  }

  func generateDummyPointsForArc(_ curve: CurveDefinition) -> [CGPoint] {
    print("Calculating dummy points for curve data \(curve).")
    let points: [CGPoint] = []

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
