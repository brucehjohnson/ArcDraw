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
  var arcDefinitions: [ArcDefinition] = [
    ArcDefinition(
      name: "Arc 1",
      description: "This is the first arc.",
      dotLocations: [
        CGPoint(x: 100, y: 100),
        CGPoint(x: 200, y: 100),
        CGPoint(x: 200, y: 200),
      ],
      startAngle: 0,
      endAngle: 90,
      isClockwise: true,
      num: 1
    ),
    ArcDefinition(
      name: "Arc 2",
      description: "This is the second arc.",
      dotLocations: [
        CGPoint(x: 300, y: 100),
        CGPoint(x: 400, y: 100),
        CGPoint(x: 400, y: 200),
      ],
      startAngle: 45,
      endAngle: 180,
      isClockwise: false,
      num: 2
    ),
    ArcDefinition(
      name: "Arc 3",
      description: "This is the third arc.",
      dotLocations: [
        CGPoint(x: 150, y: 300),
        CGPoint(x: 250, y: 300),
        CGPoint(x: 250, y: 400),
      ],
      startAngle: -30,
      endAngle: 120,
      isClockwise: true,
      num: 3
    ),

  ]

  init() {
  }

  /**
   Initialize with an array of ArcDefinitions
   - Parameter arcDefinitions: an array of ArcDefinitions
   */
  init(arcDefinitions: [ArcDefinition]) {
    self.arcDefinitions = arcDefinitions
  }

  init(imageWidth: Int, imageHeight: Int, pictureName: String, pictureDescription: String, author: String, arcDefinitions: [ArcDefinition]) {
    self.imageWidth = imageWidth
    self.imageHeight = imageHeight
    self.pictureName = pictureName
    self.pictureDescription = pictureDescription
    self.author = author
    self.arcDefinitions = arcDefinitions
  }

  static func ==(lhs: PictureDefinition, rhs: PictureDefinition) -> Bool {
    let result = lhs.imageWidth == rhs.imageWidth &&
    lhs.imageHeight == rhs.imageHeight &&
    lhs.pictureName == rhs.pictureName &&
    lhs.pictureDescription == rhs.pictureDescription &&
    lhs.author == rhs.author &&
    lhs.arcDefinitions == rhs.arcDefinitions
    return result
  }
}
