import AppKit
import CoreGraphics
import ImageIO
import SwiftUI
import UniformTypeIdentifiers

// Global variable holding a context image.
var contextImageGlobal: CGImage?

@available(macOS 12.0, *)
final class ArcDrawDocument: ReferenceFileDocument, ObservableObject {

  // Observable properties that will cause UI updates when modified.
  @Published var picdef: PictureDefinition
  @Published var selectedCurveIndex: Int?
  @Published var selectedDotIndex: Int?
  @Published var shouldUnfocus: Bool = false
  @Published var isReadOnly: Bool = false
  @Published var showReadOnlyAlert: Bool = false
  @Published var selectedExample: String { // Step 1: Add this property
    didSet {
      loadExampleJSONAndUpdate(selectedExample)
    }
  }

  // State variables for error alert handling.
  @State private var showAlert = false
  @State private var alertMessage = ""

  // Name of the document.
  var docName: String = "unknown"

  // Specify the content types that this document can read.
  static var readableContentTypes: [UTType] { [.arcdrawDocType] }

  // Define a type for snapshot serialization.
  typealias Snapshot = PictureDefinition

  // Controller responsible for drawing functionality.
  lazy var drawingController: DrawingController = {
    let selectedExampleBinding = Binding(
      get: { self.selectedExample },
      set: { self.selectedExample = $0 }
    )
    return DrawingController(doc: self, selectedExample: selectedExampleBinding)
  }()

  // ================ INITIALIZERS =========================

  // Designated initializer
  init(picdef: PictureDefinition = PictureDefinition(curves: [CurveDefinition()]), selectedExample: String = "", docName: String = "unknown") {
    self.picdef = picdef
    self.selectedExample = selectedExample
    self.docName = docName

    let selectedExampleBinding = Binding(
      get: { self.selectedExample },
      set: { self.selectedExample = $0 }
    )

    self.drawingController = DrawingController(doc: self, selectedExample: selectedExampleBinding)

    // Load the example based on the selected example.
    loadExampleJSONAndUpdate(selectedExample)
    print("Document initialized: \(Unmanaged.passUnretained(self).toOpaque())")
  }

  // Initialize with a provided example.
  convenience init(example: PictureDefinition) {
    self.init(picdef: example)
    self.isReadOnly = true
    print("Document initialized (EXAMPLE): \(Unmanaged.passUnretained(self).toOpaque())")
  }

  // Initialize with a configuration.
  convenience init(configuration: ReadConfiguration) throws {
    guard let data = configuration.file.regularFileContents else {
      throw CocoaError(.fileReadCorruptFile)
    }
    let picdef = try JSONDecoder().decode(PictureDefinition.self, from: data)
    let docName = configuration.file.filename!
    self.init(picdef: picdef, docName: docName)
    print("Document initialized (CONFIG): \(Unmanaged.passUnretained(self).toOpaque())")
  }

  // resetter
  func resetDocumentState() {
    print("Resetting selected example and everything")
    print("Document being reset: \(Unmanaged.passUnretained(self).toOpaque())")
    self.selectedExample = ""
    self.selectedCurveIndex = nil
    self.selectedDotIndex = nil
    self.shouldUnfocus = false
    self.isReadOnly = false
    self.showReadOnlyAlert = false
  }

  // ================ FUNCTIONS =========================

  func hasUnsavedChanges() -> Bool {
    if docName == "unknown" {
      print("Changes have not been saved to a document file.")
      return true
    }

    // TODO: compare current picdef with picdef loaded from file
    // if different, return true

    else {
      print("No changes to document \(docName) detected.")
      return false
    }

  }

  func saveChanges() {
    print("Saving changes")
    saveArcDrawDataFile()
  }

  // Save the data to a file.
  func saveArcDrawDataFile() {
    // first, save the data file and wait for it to complete
    DispatchQueue.main.async {
      // Trigger a "File > Save" menu event to update the app's UI.
      NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)
    }
  }

  func userDidEditDocument() {
    if isReadOnly {
      promptToSaveAsNewDocument()
    }
  }

  func promptToSaveAsNewDocument() {
    showReadOnlyAlert = true
  }

  // Method to load a default document.
  func loadDefaultDocument() {
    // todo - complete this
  }

  // Display an error message.
  func handleLoadingError(with message: String) {
    self.alertMessage = message
    self.showAlert = true
  }

  // Load and decode JSON representation of an example.
  func loadExampleJSONAndUpdate(_ exampleName: String) {
    if exampleName.isEmpty {
      loadDefaultDocument()
      return
    }
    selectedDotIndex = nil
    selectedCurveIndex = nil
    guard let url = Bundle.main.url(forResource: exampleName, withExtension: "arcdraw") else {
      print("Failed to find example JSON file named \(exampleName).")
      handleLoadingError(with: "The requested example is not available.")
      return
    }

    do {
      let exampleJSONData = try Data(contentsOf: url)
      if let jsonString = String(data: exampleJSONData, encoding: .utf8) {
        print("\(exampleName) Example JSON from URL: \(jsonString)")
      } else {
        print("\(exampleName) Failed to convert JSON data to string.")
      }

      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let pictureDefinition = try decoder.decode(PictureDefinition.self, from: exampleJSONData)

      self.picdef = pictureDefinition
      updateCurves(self.picdef.curves)
      self.objectWillChange.send()
    } catch {
      let msg = "Error occurred while trying to load \(exampleName).arcdraw: \(error)"
      print(msg)
      handleLoadingError(with: msg)
    }
  }

  // Load and decode JSON representation of a document.
  func loadJSONAndUpdate(_ fileName: String) {
    if fileName.isEmpty {
      loadDefaultDocument()
      return
    }
    selectedDotIndex = nil
    selectedCurveIndex = nil
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "arcdraw") else {
      print("Failed to find JSON file named \(fileName).")
      handleLoadingError(with: "The requested file is not available.")
      return
    }

    do {
      let data = try Data(contentsOf: url)
      if let jsonString = String(data: data, encoding: .utf8) {
        print("\(fileName) JSON from URL: \(jsonString)")
      } else {
        print("\(fileName) Failed to convert JSON data to string.")
      }

      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let pictureDefinition = try decoder.decode(PictureDefinition.self, from: data)

      self.picdef = pictureDefinition
      updateCurves(self.picdef.curves)
      self.objectWillChange.send()
    } catch {
      let msg = "Error occurred while trying to load \(fileName).arcdraw: \(error)"
      print(msg)
      handleLoadingError(with: msg)
    }
  }

  // Retrieve the title of the current window.
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

  // Create a snapshot for serialization.
  @available(macOS 12.0, *)
  func snapshot(contentType _: UTType) throws -> PictureDefinition {
    self.picdef // return the current state
  }

}
