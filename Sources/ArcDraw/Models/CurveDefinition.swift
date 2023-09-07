import Foundation

@available(macOS 12.0, *)
struct CurveDefinition: Codable, Equatable {
  var num: Int
  var name: String
  var description: String
  var dots: [DotDefinition]
  var startAngle: Double
  var endAngle: Double
  var isClockwise: Bool

  init(number: Int? = nil) {
    let curveNumber = number ?? 1
    self.num = curveNumber
    self.name = "Curve \(curveNumber)"
    self.description = "Curve \(curveNumber)"
    self.dots = []
    self.startAngle = 0.0
    self.endAngle = 0.0
    self.isClockwise = true
  }

  init(num: Int = 1, name: String = "Name", description: String = "Description", dots: [DotDefinition] = [], startAngle: Double = 0.0, endAngle: Double = 0.0, isClockwise: Bool = true) {
    self.num = num
    self.name = name
    self.description = description
    self.dots = dots
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

  // Function to add a new dot before the selected dot
  mutating func addDotBefore(selectedDotIndex: Int?) {
    guard let index = selectedDotIndex else {
      print("Dot index is nil.")
      return
    }
    guard index >= 0 && index <= dots.count else {
      print("Invalid dot index: \(index)")
      return
    }
    let newDot = DotDefinition(num: dots.count + 1, x: "newX", y: "newY")
    dots.insert(newDot, at: index)
    renumberDots()
  }

  // Function to add a new dot after the selected dot
  mutating func addDotAfter(selectedDotIndex: Int?) {
    guard let index = selectedDotIndex else {
      print("Dot index is nil.")
      return
    }
    guard index >= 0 && index < dots.count else {
      print("Invalid dot index: \(index)")
      return
    }
    let newDot = DotDefinition(num: dots.count + 1, x: "newX", y: "newY")
    dots.insert(newDot, at: index + 1)
    renumberDots()
  }

  // Function to delete the selected dot
  mutating func deleteSelectedDot(selectedDotIndex: Int?) {
    guard let index = selectedDotIndex else {
      print("Dot index is nil.")
      return
    }
    guard index >= 0 && index < dots.count else {
      print("Invalid dot index: \(index)")
      return
    }
    dots.remove(at: index)
    renumberDots()
  }

  // Function to move a dot within the list
  mutating func moveDot(from sourceIndex: Int, to destinationIndex: Int) {
    guard sourceIndex >= 0, sourceIndex < dots.count,
          destinationIndex >= 0, destinationIndex < dots.count else {
      print("Invalid source or destination index.")
      return
    }

    let movedDot = dots.remove(at: sourceIndex)
    dots.insert(movedDot, at: destinationIndex)
  }

  // Helper function to renumber the dot num values
  mutating func renumberDots() {
    for (index, var dot) in dots.enumerated() {
      dot.num = index + 1
      dots[index] = dot
    }
  }

}
