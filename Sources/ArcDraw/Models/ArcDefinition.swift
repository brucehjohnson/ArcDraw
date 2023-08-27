import Foundation

@available(macOS 12.0, *)
struct ArcDefinition: Codable, Equatable {
  var name: String = "Name"
  var description: String = "Description"
  var dotLocations: [CGPoint]
  var startAngle: Double = 0.0
  var endAngle: Double = 0.0
  var isClockwise: Bool = true
  var num: Int = 1

  init(dotLocations: [CGPoint] = [CGPoint(x: 25, y: 25)]) {
    self.dotLocations = dotLocations
  }

  init(
    name: String = "Name",
    description: String = "Description",
    dotLocations: [CGPoint] = [CGPoint(x: 25, y: 25)],
    startAngle: Double = 0.0,
    endAngle: Double = 0.0,
    isClockwise: Bool = true,
    num: Int = 1
  ) {
    self.name = name
    self.description = description
    self.dotLocations = dotLocations
    self.startAngle = startAngle
    self.endAngle = endAngle
    self.isClockwise = isClockwise
  }

  static func ==(lhs: ArcDefinition, rhs: ArcDefinition) -> Bool {
    let result = lhs.name == rhs.name &&
    lhs.description == rhs.description &&
    lhs.dotLocations == rhs.dotLocations &&
    lhs.startAngle == rhs.startAngle &&
    lhs.endAngle == rhs.endAngle &&
    lhs.isClockwise == rhs.isClockwise &&
    lhs.num == rhs.num
    return result
  }
}
