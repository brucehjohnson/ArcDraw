import SwiftUI

class DrawingController: ObservableObject {
  @Published var lines: [Line] = []

  init(picdef: PictureDefinition) {
    populateDotsFromPicdef(picdef: picdef)
  }

  func getCGPointsForArcDefinition(arcDefinition: ArcDefinition) -> [CGPoint] {
    var points: [CGPoint] = []

    for dotLocation in arcDefinition.dotLocations {
      if let xString = dotLocation["x"],
         let yString = dotLocation["y"],
         let xInteger = getIntFromPossibleSumString(dataString: xString),
         let yInteger = getIntFromPossibleSumString(dataString: yString) {
        let point = CGPoint(x: xInteger, y: yInteger)
        print("point: \(xInteger), \(yInteger)")
        points.append(point)
      }
    }
    return points
  }

  func populateDotsFromPicdef(picdef: PictureDefinition) {
    // Clear existing lines
    lines.removeAll()

    for arc in picdef.arcDefinitions {
      var points: [CGPoint] = getCGPointsForArcDefinition(arcDefinition: arc)
      for point in points {
            points.append(point)
        }
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

  func generateDummyPointsForArc(_ arc: ArcDefinition) -> [CGPoint] {
    print("Calculating dummy points for arc data \(arc).")
    var points: [CGPoint] = []

//    for dotLocation in arc.dotLocations {
//      let xString = docLocation["x"]
//      let yString = docLocation["y"]
//
//      let xInteger = getIntFromPossibleSumString(dataString: xString)
//      let yInteger = getIntFromPossibleSumString(dataString: yString)
//
//      if xInteger && yInteger {
//        let point = CGPoint(x: xInteger, y: yInteger)
//        print ("point: \(x), \(y)")
//        points.append(point)
//      }
//    }

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
