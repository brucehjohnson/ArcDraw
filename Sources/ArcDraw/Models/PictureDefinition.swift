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
  var curveData: [CurveData] = []

  init() {

  }

  init(imageWidth: Int, imageHeight: Int, pictureName: String, pictureDescription: String, author: String, curves: [CurveData]) {
    self.imageWidth = imageWidth
    self.imageHeight = imageHeight
    self.pictureName = pictureName
    self.pictureDescription = pictureDescription
    self.author = author
    self.curveData = curves
  }

  static func ==(lhs: PictureDefinition, rhs: PictureDefinition) -> Bool {
    let result = lhs.imageWidth == rhs.imageWidth &&
    lhs.imageHeight == rhs.imageHeight &&
    lhs.pictureName == rhs.pictureName &&
    lhs.pictureDescription == rhs.pictureDescription &&
    lhs.author == rhs.author &&
    lhs.curveData == rhs.curveData
    return result
  }
}


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

