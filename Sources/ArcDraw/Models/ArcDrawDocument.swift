import AppKit
import CoreGraphics
import ImageIO
import SwiftUI
import UniformTypeIdentifiers

var contextImageGlobal: CGImage?

@available(macOS 12.0, *)
final class ArcDrawDocument: ReferenceFileDocument, ObservableObject {

  @Published var picdef: PictureDefinition
  @Published var selectedCurveIndex: Int? {
    didSet {
      selectedDotIndex = nil // Reset
    }
  }
  @Published var selectedDotIndex: Int?
  @Published var shouldUnfocus: Bool = false

  var docName: String = "unknown"
  static var readableContentTypes: [UTType] { [.arcdrawDocType] }

  // snapshot used to serialize and save current version
  // while active self remains editable by the user
  typealias Snapshot = PictureDefinition

  init() {
    self.picdef = PictureDefinition(curves: [CurveDefinition()])
  }

  init(example: PictureDefinition) {
    self.picdef = example
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
  }

  // ===================================== CURVES

  func addCurveAfter(atCurveIndex curveIndex: Int) {
    let newCurve = CurveDefinition()
    if picdef.curves.isEmpty {
      picdef.curves.append(newCurve)
      selectedCurveIndex = 0
    } else {
      picdef.curves.insert(newCurve, at: curveIndex + 1)
      selectedCurveIndex = curveIndex + 1
    }
    selectedDotIndex = nil // Reset selectedDotIndex
  }

  func addCurveAfter(atArcIndex arcIndex: Int) {
    let newArc = CurveDefinition()
    let insertionIndex = arcIndex + 1
    picdef.curves.insert(newArc, at: insertionIndex)
    selectedCurveIndex = insertionIndex
    selectedDotIndex = nil // Reset selectedDotIndex
  }

  func deleteCurve(atArcIndex arcIndex: Int) {
    if picdef.curves.indices.contains(arcIndex) {
      picdef.curves.remove(at: arcIndex)
      selectedCurveIndex = nil // Reset selectedArcIndex
      selectedDotIndex = nil // Reset selectedDotIndex
    }
  }

  // ================================= DOTS

  func addDotBefore(atCurveIndex curveIndex: Int, dotIndex: Int) {
    guard picdef.curves.indices.contains(curveIndex),
          picdef.curves[curveIndex].dots.indices.contains(dotIndex) else {
      return // Invalid indices, do nothing
    }

    // Increase the num of all dots after the insertion point
    for index in dotIndex..<picdef.curves[curveIndex].dots.count {
      picdef.curves[curveIndex].dots[index].num += 1
    }

    // Create a new dot with the next num and insert it at the specified index
    let newDot = DotDefinition(num: picdef.curves[curveIndex].dots[dotIndex].num,
                               x: "25",
                               y: "25")
    picdef.curves[curveIndex].dots.insert(newDot, at: dotIndex)
    selectedDotIndex = dotIndex // Set  to the newly added dot
  }

  func addDotAfter(atCurveIndex curveIndex: Int, dotIndex: Int) {
    guard picdef.curves.indices.contains(curveIndex),
          picdef.curves[curveIndex].dots.indices.contains(dotIndex) else {
      return // Invalid indices, do nothing
    }

    // Increase the num of all dots after the insertion point
    for index in (dotIndex + 1)..<picdef.curves[curveIndex].dots.count {
      picdef.curves[curveIndex].dots[index].num += 1
    }

    // Create a new dot with the next num and insert it after the specified index
    let newDot = DotDefinition(num: picdef.curves[curveIndex].dots[dotIndex].num + 1,
                               x: "25",
                               y: "25")
    let insertionIndex = dotIndex + 1
    picdef.curves[curveIndex].dots.insert(newDot, at: insertionIndex)
    selectedDotIndex = insertionIndex // Set  to the newly added dot
  }

    func deleteDot(atCurveIndex curveIndex: Int, dotIndex: Int) {
      guard picdef.curves.indices.contains(curveIndex),
            picdef.curves[curveIndex].dots.indices.contains(dotIndex) else {
        return // Invalid indices, do nothing
      }

      picdef.curves[curveIndex].dots.remove(at: dotIndex)
      selectedDotIndex = nil // Reset -  dot is deleted
    }

  // ========================================= LOAD

  func loadExampleJSONAndUpdate(_ exampleName: String) {
    selectedDotIndex = nil
    selectedCurveIndex = nil
    if let url = Bundle.main.url(forResource: exampleName, withExtension: "json") {
      do {
        let exampleJSONData = try Data(contentsOf: url)
        if let jsonString = String(data: exampleJSONData, encoding: .utf8) {
          print("\(exampleName) Example JSON from URL: \(jsonString)")
        } else {
          print("\(exampleName) Failed to convert JSON data to string.")
        }

        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase // Use this if keys are in snake_case
          let pictureDefinition = try decoder.decode(PictureDefinition.self, from: exampleJSONData)
          self.picdef = pictureDefinition
          self.objectWillChange.send()

        } catch {
          print("Failed to decode example JSON:", error)
        }
      } catch {
        print("Failed to load example JSON data:", error)
      }
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
    print("adding new arc definition (curve)")
    self.picdef.curves.append(CurveDefinition())
    let newLength = self.picdef.curves.count
    self.picdef.curves[newLength - 1].num = newLength
    let count = self.picdef.curves.count
    undoManager?.registerUndo(withTarget: self) { doc in
      withAnimation {
        doc.deleteArcDefinition(index: count - 1, undoManager: undoManager)
      }
    }
  }

  // Deletes at an index, and registers an undo action.
  func deleteArcDefinition(index: Int, undoManager: UndoManager? = nil) {
    let oldArcDefinitions = self.picdef.curves
    withAnimation {
      _ = picdef.curves.remove(at: index)
    }

    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceArcDefinitions(with: oldArcDefinitions, undoManager: undoManager)
    }
  }

  // Replaces the existing items with a new set of items.
  func replaceArcDefinitions(with newArcDefinitions: [CurveDefinition], undoManager: UndoManager? = nil, animation: Animation? = .default) {
    let oldArcDefinitions = self.picdef.curves

    withAnimation(animation) {
      picdef.curves = newArcDefinitions
    }

    undoManager?.registerUndo(withTarget: self) { doc in
      // Because you recurse here, redo support is automatic.
      doc.replaceArcDefinitions(with: oldArcDefinitions, undoManager: undoManager, animation: animation)
    }
  }

  // Relocates the specified items, and registers an undo action.
  func moveArcDefinitionsAt(offsets: IndexSet, toOffset: Int, undoManager: UndoManager? = nil) {
    let oldArcDefinitions = self.picdef.curves
    withAnimation {
      picdef.curves.move(fromOffsets: offsets, toOffset: toOffset)
    }

    undoManager?.registerUndo(withTarget: self) { doc in
      // Use the replaceItems symmetric undoable-redoable function.
      doc.replaceArcDefinitions(with: oldArcDefinitions, undoManager: undoManager)
    }
  }

  // Registers an undo action and a redo action for a hue change
  func registerUndoHueChange(for arcDefinition: CurveDefinition, oldArcDefinition: CurveDefinition, undoManager: UndoManager?) {
    let index = self.picdef.curves.firstIndex(of: arcDefinition)!

    // The change has already happened, so save the collection of new items.
    let newArcDefinitions = self.picdef.curves

    // Register the undo action.
    undoManager?.registerUndo(withTarget: self) { doc in
      doc.picdef.curves[index] = oldArcDefinition

      // Register the redo action.
      undoManager?.registerUndo(withTarget: self) { doc in
        // Use the replaceItems symmetric undoable-redoable function.
        doc.replaceArcDefinitions(with: newArcDefinitions, undoManager: undoManager, animation: nil)
      }
    }
  }

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
