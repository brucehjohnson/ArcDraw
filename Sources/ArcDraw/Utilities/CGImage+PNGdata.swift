import SwiftUI
import UniformTypeIdentifiers

@available(macOS 10.13, *)
extension CGImage {
  func pngData() -> Data? {
    guard let mutableData = CFDataCreateMutable(nil, 0) else {
      print("Error creating mutable data")
      return nil
    }

    guard let dest = CGImageDestinationCreateWithData(mutableData, UTType.png.identifier as CFString, 1, nil) else {
      print("Error creating image destination")
      return nil
    }

    CGImageDestinationAddImage(dest, self, nil)

    if CGImageDestinationFinalize(dest) {
      return mutableData as Data
    } else {
      print("Error finalizing image destination")
      return nil
    }
  }
}
