/**
 A document for creating and editing ArcDraw pictures.

 ArcDrawDocument is a reference file document that supports only reading and writing ArcDraw data files.
 Its snapshot is a PictureDefinition and it has a @Published picdef property that, when changed,
 triggers a reload of all views using the document. This document class also has a docName
 property for the name of the data document and a simple initializer that creates a new demo ArcDraw.

 For more information, see:
 https://www.hackingwithswift.com/quick-start/swiftui/
 how-to-create-a-document-based-app-using-filedocument-and-documentgroup

 Note: This class is only available on macOS 12.0 and later.
 */
import AppKit
import CoreGraphics
import ImageIO
import SwiftUI
import UniformTypeIdentifiers

var contextImageGlobal: CGImage?

 /**
  A utility class to work with files for saving and sharing your art.

 Note: Since ArcDrawDocument is a class, we derive from
 [ReferenceFileDocument](
 https://developer.apple.com/documentation/swiftui/referencefiledocument
 )
 rather than FileDocument for a struct.
*/
@available(macOS 12.0, *)
final class ArcDrawDocument: ReferenceFileDocument, ObservableObject {

  var docName: String = "unknown"
  static var readableContentTypes: [UTType] { [.arcdrawDocType] }

  // snapshot used to serialize and save current version
  // while active self remains editable by the user
  typealias Snapshot = PictureDefinition

  // our document has a @Published picdef property,
  // so when picdef is changed,
  // all views using that document will be reloaded
  // to reflect the picdef changes
  @Published var picdef: PictureDefinition

  /**
   A simple initializer that creates a new demo picture
   */
  init() {
    let arcDefinitions: [ArcDefinition] = [
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
    self.picdef = PictureDefinition(arcDefinitions: arcDefinitions)
  }

  /**
   Initialize a document with our picdef property
   - Parameter configuration: config
   */
  init(configuration: ReadConfiguration) throws {
    guard let data = configuration.file.regularFileContents else {
      throw CocoaError(.fileReadCorruptFile)
    }
    self.picdef = try JSONDecoder().decode(PictureDefinition.self, from: data)
    self.docName = configuration.file.filename!
    print("Opening data file = ", self.docName)
  }

  func loadExampleJSONAndUpdate(_ exampleName: String) {
    print("Calling loadExampleJSONAndUpdate for \(exampleName).")
    if let url = Bundle.main.url(forResource: exampleName, withExtension: "json") {
      print("Attempting to load example JSON from URL: \(url)")
      if let exampleJSONData = try? Data(contentsOf: url) {
        if let jsonString = String(data: exampleJSONData, encoding: .utf8) {
          print("Example JSON from URL: \(jsonString)")
        } else {
          print("Failed to convert JSON data to string.")
        }
        if let pictureDefinition = try? JSONDecoder().decode(PictureDefinition.self, from: exampleJSONData) {
          self.picdef = pictureDefinition
        } else {
          print("Failed to decode example JSON.")
        }}

    } else {
      print("Failed to find example JSON file.")
    }
  }

  /**
   Get the current window title (shows data file name).
   */
  func getCurrentWindowTitle() -> String {
    guard let mainWindow = NSApp.mainWindow else {
      return ""
    }
    return mainWindow.title
  }

  /**
   Save the active picture definittion data to a file.
   - Parameters:
   - snapshot: snapshot of the current state
   - configuration: write config
   - Returns: a fileWrapper
   */
  func fileWrapper(
    snapshot: PictureDefinition,
    configuration _: WriteConfiguration
  ) throws -> FileWrapper {
    let data = try JSONEncoder().encode(snapshot)
    let fileWrapper = FileWrapper(regularFileWithContents: data)
    return fileWrapper
  }

  // Save the data to a file.
  func saveArcDrawDataFile() {
    // first, save the data file and wait for it to complete
    DispatchQueue.main.async {
      // Trigger a "File > Save" menu event to update the app's UI.
      NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)
    }
  }

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
    guard let destination = CGImageDestinationCreateWithURL(imageURL as CFURL, kUTTypePNG, 1, nil) else {
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

  /**
   Create a snapshot of the current state of the document for serialization
   while the live self remains editiable by the user
   - Parameter contentType: the standard type we use
   - Returns: picture definition
   */
  @available(macOS 12.0, *)
  func snapshot(contentType _: UTType) throws -> PictureDefinition {
    self.picdef // return the current state
  }

}

// Provide operations on the document.
@available(macOS 12.0, *)
extension ArcDrawDocument {
  // Adds a new arc Definition, and registers an undo action.
  func addArcDefinition(undoManager: UndoManager? = nil) {
    self.picdef.arcDefinitions.append(ArcDefinition())
    let newLength = self.picdef.arcDefinitions.count
    self.picdef.arcDefinitions[newLength - 1].num = newLength
    let count = self.picdef.arcDefinitions.count
    undoManager?.registerUndo(withTarget: self) { doc in
      withAnimation {
        doc.deleteArcDefinition(index: count - 1, undoManager: undoManager)
      }
    }
  }

  // Deletes at an index, and registers an undo action.
  func deleteArcDefinition(index: Int, undoManager: UndoManager? = nil) {
    let oldArcDefinitions = self.picdef.arcDefinitions
    withAnimation {
      _ = picdef.arcDefinitions.remove(at: index)
    }

    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceArcDefinitions(with: oldArcDefinitions, undoManager: undoManager)
    }
  }

  // Replaces the existing items with a new set of items.
  func replaceArcDefinitions(with newArcDefinitions: [ArcDefinition], undoManager: UndoManager? = nil, animation: Animation? = .default) {
    let oldArcDefinitions = self.picdef.arcDefinitions

    withAnimation(animation) {
      picdef.arcDefinitions = newArcDefinitions
    }

    undoManager?.registerUndo(withTarget: self) { doc in
      // Because you recurse here, redo support is automatic.
      doc.replaceArcDefinitions(with: oldArcDefinitions, undoManager: undoManager, animation: animation)
    }
  }

  // Relocates the specified items, and registers an undo action.
  func moveArcDefinitionsAt(offsets: IndexSet, toOffset: Int, undoManager: UndoManager? = nil) {
    let oldArcDefinitions = self.picdef.arcDefinitions
    withAnimation {
      picdef.arcDefinitions.move(fromOffsets: offsets, toOffset: toOffset)
    }

    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceArcDefinitions(with: oldArcDefinitions, undoManager: undoManager)
    }
  }

  // Registers an undo action and a redo action for a hue change
  func registerUndoHueChange(for arcDefinition: ArcDefinition, oldArcDefinition: ArcDefinition, undoManager: UndoManager?) {
    let index = self.picdef.arcDefinitions.firstIndex(of: arcDefinition)!

    // The change has already happened, so save the collection of new items.
    let newArcDefinitions = self.picdef.arcDefinitions

    // Register the undo action.
    undoManager?.registerUndo(withTarget: self) { doc in
      doc.picdef.arcDefinitions[index] = oldArcDefinition

      // Register the redo action.
      undoManager?.registerUndo(withTarget: self) { doc in
        // Use the replaceItems symmetric undoable-redoable function.
        doc.replaceArcDefinitions(with: newArcDefinitions, undoManager: undoManager, animation: nil)
      }
    }
  }

  /*
  func updateHueWithColorNumberB(index: Int, newValue: Double, undoManager: UndoManager? = nil) {
    let oldHues = self.picdef.hues
    let oldHue = self.picdef.hues[index]
    let newHue = Hue(
      num: oldHue.num,
      r: oldHue.r,
      g: oldHue.g,
      b: newValue
    )
    self.picdef.hues[index] = newHue
    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceHues(with: oldHues, undoManager: undoManager)
    }
  }

  func updateHueWithColorNumberG(index: Int, newValue: Double, undoManager: UndoManager? = nil) {
    let oldHues = self.picdef.hues
    let oldHue = self.picdef.hues[index]
    let newHue = Hue(
      num: oldHue.num,
      r: oldHue.r,
      g: newValue,
      b: oldHue.b
    )
    self.picdef.hues[index] = newHue
    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceHues(with: oldHues, undoManager: undoManager)
    }
  }

  func updateHueWithColorNumberR(index: Int, newValue: Double, undoManager: UndoManager? = nil) {
    let oldHues = self.picdef.hues
    let oldHue = self.picdef.hues[index]
    let newHue = Hue(
      num: oldHue.num,
      r: newValue,
      g: oldHue.g,
      b: oldHue.b
    )
    self.picdef.hues[index] = newHue
    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceHues(with: oldHues, undoManager: undoManager)
    }
  }

  /**
   Update an ordered color with a new selection from the ColorPicker
   - Parameters:
   - index: an Int for the index of this ordered color
   - newColorPick: the Color of the new selection
   - undoManager: undoManager
   */
  func updateHueWithColorPick(index: Int, newColorPick: Color, undoManager: UndoManager? = nil) {
    let oldHues = self.picdef.hues
    let oldHue = self.picdef.hues[index]
    if let arr = newColorPick.cgColor {
      let newHue = Hue(
        num: oldHue.num,
        r: arr.components![0] * 255.0,
        g: arr.components![1] * 255.0,
        b: arr.components![2] * 255.0
      )
      self.picdef.hues[index] = newHue
    }
    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceHues(with: oldHues, undoManager: undoManager)
    }
  }
   */
}

// Helper utility
// Extending String functionality so we can use indexes to get substrings
@available(macOS 12.0, *)
extension String {
  subscript(_ range: CountableRange<Int>) -> String {
    let start = index(startIndex, offsetBy: max(0, range.lowerBound))
    let end = index(start, offsetBy: min(
      count - range.lowerBound,
      range.upperBound - range.lowerBound
    ))
    return String(self[start ..< end])
  }

  subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
    let start = index(startIndex, offsetBy: max(0, range.lowerBound))
    return String(self[start...])
  }
}

/**
 Extend UTType to include org.bhj.arcdraw (.arcdraw) files.
 */
@available(macOS 11.0, *)
extension UTType {
  static let arcdrawDocType = UTType(importedAs: "org.bhj.arcdraw")
}

/** Extend CGImage to add pngData()
 */
@available(macOS, introduced: 10.13)
extension CGImage {
  func pngData() -> Data? {
    let mutableData = CFDataCreateMutable(nil, 0)!
    let dest = CGImageDestinationCreateWithData(mutableData, kUTTypePNG, 1, nil)!
    CGImageDestinationAddImage(dest, self, nil)
    if CGImageDestinationFinalize(dest) {
      return mutableData as Data
    }
    return nil
  }
}
