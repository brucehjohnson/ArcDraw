import Foundation
import SwiftUI

@available(macOS 12.0, *)
struct PictureDefinition: Codable, Identifiable, Equatable {

  var id = UUID()

  var imageWidth: Int = 1100
  var imageHeight: Int = 1000
  var pictureName: String = "Name"
  var pictureDescription: String = "Description"
  var author: String = "Your Name"
  var curves: [CurveData] = []

  init() {

  }

  init(imageWidth: Int, imageHeight: Int, pictureName: String, pictureDescription: String, author: String, curves: [CurveData]) {
    self.imageWidth = imageWidth
    self.imageHeight = imageHeight
    self.pictureName = pictureName
    self.pictureDescription = pictureDescription
    self.author = author
    self.curves = curves
  }

  static func ==(lhs: PictureDefinition, rhs: PictureDefinition) -> Bool {
    let result = lhs.imageWidth == rhs.imageWidth &&
    lhs.imageHeight == rhs.imageHeight &&
    lhs.pictureName == rhs.pictureName &&
    lhs.pictureDescription == rhs.pictureDescription &&
    lhs.author == rhs.author &&
    lhs.curves == rhs.curves
    return result
  }
}
