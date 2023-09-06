import Foundation

@available(macOS 12.0, *)
struct PictureDefinition: Codable, Identifiable, Equatable {

  var id = UUID()
  var imageWidth: Int = 1100
  var imageHeight: Int = 1000
  var pictureName: String = "Name"
  var pictureDescription: String = "Description"
  var author: String = "Your Name"
  var curves: [CurveDefinition]

  init() {
    self.curves = [CurveDefinition()]
  }

  init(curves: [CurveDefinition]) {
    self.curves = curves
  }

  init(imageWidth: Int, imageHeight: Int, pictureName: String, pictureDescription: String, author: String, curves: [CurveDefinition]) {
    self.imageWidth = imageWidth
    self.imageHeight = imageHeight
    self.pictureName = pictureName
    self.pictureDescription = pictureDescription
    self.author = author
    self.curves = curves
  }

  // move a curve within the list of curves
  mutating func moveCurve(from sourceIndex: Int, to destinationIndex: Int) {
    guard sourceIndex >= 0, sourceIndex < curves.count,
          destinationIndex >= 0, destinationIndex < curves.count else {
      print("Invalid source or destination index.")
      return
    }
    let movedCurve = curves.remove(at: sourceIndex)
    curves.insert(movedCurve, at: destinationIndex)
  }

  // Helper function to re-number the curve num values
  mutating func renumberCurves() {
    for (index, var curve) in curves.enumerated() {
      curve.num = index + 1
      curves[index] = curve
    }
  }

  static func ==(lhs: PictureDefinition, rhs: PictureDefinition) -> Bool {
    return lhs.imageWidth == rhs.imageWidth &&
    lhs.imageHeight == rhs.imageHeight &&
    lhs.pictureName == rhs.pictureName &&
    lhs.pictureDescription == rhs.pictureDescription &&
    lhs.author == rhs.author &&
    lhs.curves == rhs.curves
  }
}
