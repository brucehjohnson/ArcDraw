import Foundation

@available(macOS 12.0, *)
struct DotDefinition: Codable, Equatable {
  var num: Int
  var x: String
  var y: String

  // Empty initializer
  init() {
    self.num = 0
    self.x = ""
    self.y = ""
  }

  // Initializer with parameters
  init(num: Int, x: String, y: String) {
    self.num = num
    self.x = x
    self.y = y
  }

  static func ==(lhs: DotDefinition, rhs: DotDefinition) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.num == rhs.num
  }
}
