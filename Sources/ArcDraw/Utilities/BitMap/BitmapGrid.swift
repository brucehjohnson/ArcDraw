import Foundation

struct BitmapGrid {

  struct GridInputs {
    let imageWidth: Int
    let imageHeight: Int
    let bytesPerPixel: Int
    let rasterBufferPtr: UnsafeMutablePointer<UInt8>
  }

  static func calculateGrid(using parameters: GridInputs) {
    let imageWidth = parameters.imageWidth
    let imageHeight = parameters.imageHeight

    let bytesPerPixel = parameters.bytesPerPixel
    let rasterBufferPtr = parameters.rasterBufferPtr

    let colorLeft = [0.0, 0.0, 0.0, 0.0]
    let colorRight = [255.0, 255.0, 255.0, 0.0]

    // Iterate over each row (vertical iteration)
    for row in 0 ..< imageHeight {
      // Iterate over each column (horizontal iteration)
      for column in 0 ..< imageWidth {

        let pixelIndex = row * imageWidth + column

        // Check if the pixelIndex is within the allocated buffer size
        if pixelIndex * bytesPerPixel < imageWidth * imageHeight * bytesPerPixel {
          let pixelAddress: UnsafeMutablePointer<UInt8> = rasterBufferPtr + pixelIndex * bytesPerPixel

          // Calculate color value for each channel
          for channel in 0 ..< 3 { // Loop over R, G, and B channels
            let channelValue: Double

              channelValue = colorRight[channel]

            // Ensure channel value is within the range [0, 255]
            pixelAddress[channel] = UInt8(max(0.0, min(255.0, channelValue)))
          }

          // Set Alpha channel to 255
          pixelAddress[3] = UInt8(255)

          // IMPORTANT: No type checking - make sure that address indexes
          // do not go beyond memory allocated for the buffer
        } else {
          // Handle error case here
          print("Error: Pixel index \(pixelIndex) is out of bounds for buffer size.")
        }
      }
    }
  }
}
