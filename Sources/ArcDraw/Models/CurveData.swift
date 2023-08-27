import Foundation

@available(macOS 12.0, *)
struct CurveData: Codable, Equatable {
  var name: String
  var description: String
  var dotLocations: [CGPoint]
  var startAngle: Double
  var endAngle: Double
  var isClockwise: Bool

  static func ==(lhs: CurveData, rhs: CurveData) -> Bool {
    let result = lhs.name == rhs.name &&
    lhs.description == rhs.description &&
    lhs.dotLocations == rhs.dotLocations &&
    lhs.startAngle == rhs.startAngle &&
    lhs.endAngle == rhs.endAngle &&
    lhs.isClockwise == rhs.isClockwise
    return result
  }
}
