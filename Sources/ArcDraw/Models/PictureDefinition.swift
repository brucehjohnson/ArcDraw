import Foundation

@available(macOS 12.0, *)
struct PictureDefinition: Codable, Identifiable, Equatable {

  var id = UUID()

  var imageWidth: Int = 1100
  var imageHeight: Int = 1000
  var pictureName: String = "Name"
  var pictureDescription: String = "Description"
  var author: String = "Your Name"
  var arcDefinitions: [ArcDefinition]

  init() {
    self.arcDefinitions = []
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
    return lhs.imageWidth == rhs.imageWidth &&
    lhs.imageHeight == rhs.imageHeight &&
    lhs.pictureName == rhs.pictureName &&
    lhs.pictureDescription == rhs.pictureDescription &&
    lhs.author == rhs.author &&
    lhs.arcDefinitions == rhs.arcDefinitions
  }
}
