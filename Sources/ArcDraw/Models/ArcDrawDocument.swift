import AppKit
import CoreGraphics
import ImageIO
import SwiftUI
import UniformTypeIdentifiers

var contextImageGlobal: CGImage?

@available(macOS 12.0, *)
final class ArcDrawDocument: ReferenceFileDocument, ObservableObject {
  @Published var picdef: PictureDefinition
  @Published var selectedCurveIndex: Int?
  @Published var selectedDotIndex: Int?
  @Published var shouldUnfocus: Bool = false
  @Published var selectedExample: String { // Step 1: Add this property
    didSet {
      loadExampleJSONAndUpdate(selectedExample)
    }
  }

  var docName: String = "unknown"
  static var readableContentTypes: [UTType] { [.arcdrawDocType] }

  // snapshot used to serialize and save current version
  // while active self remains editable by the user
  typealias Snapshot = PictureDefinition

  lazy var drawingController: DrawingController = {
    let selectedExampleBinding = Binding(
      get: { self.selectedExample },
      set: { self.selectedExample = $0 }
    )
    return DrawingController(doc: self, selectedExample: selectedExampleBinding)
  }()

  // Designated initializer
  init(picdef: PictureDefinition = PictureDefinition(curves: [CurveDefinition()]), selectedExample: String = "Shapes", docName: String = "unknown") {
    self.picdef = picdef
    self.selectedExample = selectedExample
    self.docName = docName

    let selectedExampleBinding = Binding(
      get: { self.selectedExample },
      set: { self.selectedExample = $0 }
    )

    self.drawingController = DrawingController(doc: self, selectedExample: selectedExampleBinding)
    loadExampleJSONAndUpdate(selectedExample)
  }

  // Convenience init with example
  convenience init(example: PictureDefinition) {
    self.init(picdef: example)
  }

  // Convenience init with configuration
  convenience init(configuration: ReadConfiguration) throws {
    guard let data = configuration.file.regularFileContents else {
      throw CocoaError(.fileReadCorruptFile)
    }
    let picdef = try JSONDecoder().decode(PictureDefinition.self, from: data)
    let docName = configuration.file.filename!
    self.init(picdef: picdef, docName: docName)
  }

  func loadExampleJSONAndUpdate(_ exampleName: String) {
    selectedDotIndex = nil
    selectedCurveIndex = nil

    if let url = Bundle.main.url(forResource: exampleName, withExtension: "arcdraw") {
      do {
        let exampleJSONData = try Data(contentsOf: url)
        if let jsonString = String(data: exampleJSONData, encoding: .utf8) {
          // print("\(exampleName) Example JSON from URL: \(jsonString)")
        } else {
          print("\(exampleName) Failed to convert JSON data to string.")
        }

        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase // Use this if keys are in snake_case
          let pictureDefinition = try decoder.decode(PictureDefinition.self, from: exampleJSONData)
          self.picdef = pictureDefinition
          updateCurves(self.picdef.curves)
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
