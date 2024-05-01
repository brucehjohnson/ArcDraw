import SwiftUI

class OneDocManager: ObservableObject {
  @Published var document: ArcDrawDocument = ArcDrawDocument()

  static let shared = OneDocManager() // Singleton instance

  func openDocument(doc: ArcDrawDocument) {
    document = doc
  }

  func createNewDocument() {
    document = ArcDrawDocument()
  }

}
