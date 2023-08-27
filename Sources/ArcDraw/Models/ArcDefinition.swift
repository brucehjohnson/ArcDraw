import Foundation

@available(macOS 12.0, *)
struct ArcDefinition: Codable, Equatable {
  var name: String = "Name"
  var description: String = "Description"
  var dotLocations: [[String: Int]] // Array of dictionaries
  var startAngle: Double = 0.0
  var endAngle: Double = 0.0
  var isClockwise: Bool = true
  var num: Int = 1

  init(name: String = "Name", description: String = "Description", dotLocations: [[String: Int]] = [], startAngle: Double = 0.0, endAngle: Double = 0.0, isClockwise: Bool = true, num: Int = 1) {
    self.name = name
    self.description = description
    self.dotLocations = dotLocations
    self.startAngle = startAngle
    self.endAngle = endAngle
    self.isClockwise = isClockwise
    self.num = num
  }

  static func ==(lhs: ArcDefinition, rhs: ArcDefinition) -> Bool {
    return lhs.name == rhs.name &&
    lhs.description == rhs.description &&
    lhs.dotLocations == rhs.dotLocations &&
    lhs.startAngle == rhs.startAngle &&
    lhs.endAngle == rhs.endAngle &&
    lhs.isClockwise == rhs.isClockwise &&
    lhs.num == rhs.num
  }
}
