// ArcDrawDocument+Dot
import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawDocument {

  func handleAddNewDotRequest(for curveIndex: Int, xString: String = "", yString: String = "") {
    print("Attempting to add dot to curve at index: \(curveIndex)")
    self.picdef.curves[curveIndex].addDot(xString: xString, yString: yString)
    print("Dot added successfully to curve at index: \(curveIndex)")
  }

  func deleteDot(at dotIndex: Int) {
    guard let selectedCurveIndex = self.selectedCurveIndex else {
      print("Error: No curve selected to delete a dot.")
      return
    }
    self.picdef.curves[selectedCurveIndex].deleteSelectedDot(selectedDotIndex: dotIndex)
  }

}
