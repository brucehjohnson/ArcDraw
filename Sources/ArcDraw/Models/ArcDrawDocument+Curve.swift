// ArcDrawDocument+Curve
import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawDocument {

    // Function to add a new curve
    func addNewCurve() {
      print("Called Add New Curve")
      guard let iSelected = selectedCurveIndex else {
        let lastCurveIndex = picdef.curves.count - 1
        if lastCurveIndex >= 0 {
          print("No curve selected. Adding a new curve after the last one.")
          insertCurve(afterIndex: lastCurveIndex)
        } else {
          print("No curves available. Adding a new curve at the beginning.")
          picdef.curves.insert(CurveDefinition(), at: 0)
          selectedCurveIndex = 0
        }
        return
      }
      print("Selected curve index: \(iSelected)")
      insertCurve(afterIndex: iSelected)
    }

    // Generalized function to insert a curve after a specific index
    func insertCurve(afterIndex index: Int) {
      print("Called Add Curve After")
      let newCurve = CurveDefinition()
      let insertionIndex = index + 1
      if picdef.curves.indices.contains(insertionIndex) {
        picdef.curves.insert(newCurve, at: insertionIndex)
        selectedCurveIndex = insertionIndex
        selectedDotIndex = nil // Reset selectedDotIndex
      } else {
        print("Error: Invalid index \(insertionIndex). Curve not added.")
      }
    }

    // Function to delete a curve
    func deleteCurve() {
      print("Called Clear/Delete Curve")
      guard let selectedArcIndex = selectedCurveIndex else {
        print("Error: No curve selected for deletion.")
        return
      }
      print("Selected curve index: \(selectedArcIndex)")
      removeCurve(atIndex: selectedArcIndex)
    }

    // Generalized function to delete a curve at a specific index
    private func removeCurve(atIndex index: Int) {
      if picdef.curves.indices.contains(index) {
        picdef.curves.remove(at: index)
        selectedCurveIndex = nil // Reset
        selectedDotIndex = nil // Reset
      } else {
        print("Error: Invalid index \(index). Curve not deleted.")
      }
    }

    // Function to update all curves
    func updateCurves(_ newCurves: [CurveDefinition]) {
      print("Updating All Curves")
      self.picdef.curves = newCurves
    }
  }
