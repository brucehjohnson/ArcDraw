import Foundation

@available(macOS 12.0, *)
struct CurveDefinition: Codable, Equatable {
  var num: Int = 1
  var name: String = "Name"
  var description: String = "Description"
  var dots: [DotDefinition]
  var startAngle: Double = 0.0
  var endAngle: Double = 0.0
  var isClockwise: Bool = true

  // Empty initializer
  init() {
    self.num = 1
    self.name = "Curve 1"
    self.description = "Curve 1"
    self.dots = []
    self.startAngle = 0.0
    self.endAngle = 0.0
    self.isClockwise = true
  }

  init(num: Int = 1, name: String = "Name", description: String = "Description", dotLocations: [DotDefinition] = [], startAngle: Double = 0.0, endAngle: Double = 0.0, isClockwise: Bool = true) {
    self.num = num
    self.name = name
    self.description = description
    self.dots = dotLocations
    self.startAngle = startAngle
    self.endAngle = endAngle
    self.isClockwise = isClockwise
  }

  static func ==(lhs: CurveDefinition, rhs: CurveDefinition) -> Bool {
    return lhs.name == rhs.name &&
    lhs.description == rhs.description &&
    lhs.dots == rhs.dots &&
    lhs.startAngle == rhs.startAngle &&
    lhs.endAngle == rhs.endAngle &&
    lhs.isClockwise == rhs.isClockwise &&
    lhs.num == rhs.num
  }
}
