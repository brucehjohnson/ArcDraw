// ArcDrawDocument+Curve
import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawDocument {

  // Gets a binding for the name of a curve at a specific index
  func bindingForCurveName(at index: Int) -> Binding<String> {
    return Binding<String>(
      get: {
        self.picdef.curves[index].name
      },
      set: {
        self.picdef.curves[index].name = $0
      }
    )
  }


    func handleAddNewCurveRequest() {
      print("Handle Add New Curve Request")
      print("  Selected curve index: \(selectedCurveIndex)")
      print("  Count of existing curves: \(picdef.curves.count)")

      // If no curves exist, simply add one.
      if picdef.curves.isEmpty {
        addNewCurve()
      }
      // If a curve is selected, add a new curve after the selected index.
      else if let iSelected = selectedCurveIndex {
        insertCurve(afterIndex: iSelected)
      }
      // If curves exist but none are selected, add a new curve at the end.
      else {
        addNewCurve()
      }
    }

    // Function to add a new curve
  func addNewCurve() {
    print("Called Add New Curve")
    let newCurveNumber = picdef.curves.count + 1
    print("  new curve number is \(newCurveNumber)")
    let newCurve = CurveDefinition(number: newCurveNumber)
    picdef.curves.append(newCurve)
    selectedCurveIndex = picdef.curves.count - 1
  }

  func insertCurve(afterIndex index: Int) {
    print("Called Add Curve After index \(index)")
    if index < 0 || index > picdef.curves.count {
      print("Error: Invalid index \(index). Curve not added.")
      return
    }
    let newCurveNumber = index + 2  // +1 for next index, +1 again for next number
    let newCurve = CurveDefinition(number: newCurveNumber)
    picdef.curves.insert(newCurve, at: index + 1)
    selectedCurveIndex = index + 1
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
      self.drawingController.updateDrawing(for: selectedExample)
    }
  }
