import SwiftUI

class ImageViewModel: ObservableObject {

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }
  

  /**
   Gets an image to display on the right side of the app

   - Returns: An optional CGImage or nil
   */
  func getImage() -> CGImage? {

    // self.doc.picdef.imageWidth,
    // self.doc.picdef.imageHeight

    let inputs = BitmapImage.ImageInputs(
      imageWidth: 500,
      imageHeight: 500
    )
    return BitmapImage.createCGImage(using: inputs)

  }

}
