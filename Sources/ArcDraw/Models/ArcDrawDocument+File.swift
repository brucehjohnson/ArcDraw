// ArcDrawDocument+File
import AppKit
import CoreGraphics
import ImageIO
import SwiftUI
import UniformTypeIdentifiers

@available(macOS 12.0, *)
extension ArcDrawDocument {

  func beforeSaveImage() {
    var data: Data
    do {
      data = try JSONEncoder().encode(self.picdef)
    } catch {
      print("Error encoding picdef.")
      print("Closing all windows and exiting with error code 98.")
      NSApplication.shared.windows.forEach { $0.close() }
      NSApplication.shared.terminate(nil)
      exit(98)
    }
    if data == Data() {
      print("Error encoding picdef.")
      print("Closing all windows and exiting with error code 99.")
      NSApplication.shared.windows.forEach { $0.close() }
      NSApplication.shared.terminate(nil)
      exit(99)
    }
    // trigger state change to force a current image
    self.picdef.imageHeight += 1
    self.picdef.imageHeight -= 1
  }

  func getDefaultImageFileName() -> String {
    let winTitle = self.getCurrentWindowTitle()
    let justname = winTitle.replacingOccurrences(of: ".arcdraw", with: "")
    let imageFileName = justname + ".png"
    return imageFileName
  }

  // Save the data to a file.
  func saveArcDrawDataFile() {
    // first, save the data file and wait for it to complete
    DispatchQueue.main.async {
      // Trigger a "File > Save" menu event to update the app's UI.
      NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)
    }
  }

  func getImageComment() -> String {

    let b = String(picdef.imageHeight)
    let c = String(picdef.imageWidth)

    let comment =
    "imageHeight is \(b) \n" +
    "imageWidth is \(c) \n" +
    " "
    return comment
  }

  func initSavePanel(fn: String) -> NSSavePanel {
    let savePanel = NSSavePanel()
    savePanel.title = "Choose Directory for ArcDraw image"
    savePanel.nameFieldStringValue = fn
    savePanel.canCreateDirectories = true
    return savePanel
  }

  // requires Cocoa
  // requires ImageIO
  func setPNGDescription(imageURL: URL, description: String) throws {
    // Get the image data
    guard let imageData = try? Data(contentsOf: imageURL) else {
      throw NSError(domain: "com.bhj.arcdraw", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to read image data"])
    }

    // Create a CGImageSource from the image data
    guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) else {
      throw NSError(domain: "com.bhj.arcdraw", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image source"])
    }

    // Create a CGImageDestination to write the image with metadata
    guard let destination = CGImageDestinationCreateWithURL(imageURL as CFURL, UTType.png.identifier as CFString, 1, nil) else {
      throw NSError(domain: "com.bhj.arcdraw", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image destination"])
    }

    // Get the image properties dictionary
    guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [CFString: Any] else {
      throw NSError(domain: "com.bhj.arcdraw", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image properties"])
    }

    // Create a mutable copy of the properties dictionary
    var mutableProperties = properties as [CFString: Any]

    // Add the PNG dictionary with the description attribute
    var pngProperties = [CFString: Any]()
    pngProperties[kCGImagePropertyPNGDescription] = description
    mutableProperties[kCGImagePropertyPNGDictionary] = pngProperties

    // Add the image to the destination with metadata
    CGImageDestinationAddImageFromSource(destination, imageSource, 0, mutableProperties as CFDictionary)

    // Finalize the destination to write the image with metadata to disk
    guard CGImageDestinationFinalize(destination) else {
      throw NSError(domain: "com.bhj.arcdraw", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to write image with metadata to disk"])
    }
  }

  func saveArcDrawImage() {
    beforeSaveImage()
    guard let cgImage = contextImageGlobal else {
      print("Error: No context image available.")
      return
    }
    let imageFileName: String = getDefaultImageFileName()
    let comment: String = getImageComment()
    let savePanel: NSSavePanel = initSavePanel(fn: imageFileName)

    // Set the description attribute in the PNG metadata
    let pngMetadata: [String: Any] = [
      kCGImagePropertyPNGDescription as String: comment
    ]

    savePanel.begin { result in
      if result == .OK, let url = savePanel.url {
        let imageData = cgImage.pngData()!
        let ciImage = CIImage(data: imageData, options: [.properties: pngMetadata])
        let context = CIContext(options: nil)

        guard let pngData = context.pngRepresentation(of: ciImage!, format: .RGBA8, colorSpace: ciImage!.colorSpace!) else {
          print("Error: Failed to generate PNG data.")
          return
        }

        do {
          try pngData.write(to: url, options: .atomic)
          print("Saved image to: \(url)")
          print("Description: \(comment)")
          // Description is not saved.
          // The following is needed to actually write the description
          let imageURL = url
          let description = comment
          try self.setPNGDescription(imageURL: imageURL, description: description)

        } catch let error {
          print("Error saving image: \(error)")
        }
      }
    }
  }

  func saveDocumentAsNew() {
    let savePanel = NSSavePanel()
    savePanel.allowedFileTypes = [UTType.arcdrawDocType.identifier]
    savePanel.begin { (result) in
      if result == .OK, let url = savePanel.url {
        do {
          let data = try JSONEncoder().encode(self.picdef)
          try data.write(to: url)
          self.isReadOnly = false
          self.showReadOnlyAlert = false
        } catch {
          print("Error saving document: \(error)")
          //  TODO: show an alert to the user
        }
      }
    }
  }

}
