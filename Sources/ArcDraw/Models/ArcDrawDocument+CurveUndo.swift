// ArcDrawDocument+CurveUndo
import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawDocument {

  func addNewCurve(undoManager: UndoManager? = nil) {
    print("Called Add New Curve")
    guard let selectedArcIndex = selectedCurveIndex else {
      let lastCurveIndex = picdef.curves.count - 1
      if lastCurveIndex >= 0 {
        print("No curve selected. Adding a new curve after the last one.")
        insertCurve(afterIndex: lastCurveIndex, undoManager: undoManager)
      } else {
        print("No curves available. Adding a new curve at the beginning.")
        let newCurve = CurveDefinition()
        picdef.curves.insert(newCurve, at: 0)
        selectedCurveIndex = 0
        registerUndoForInsertCurve(atIndex: 0, undoManager: undoManager)
      }
      return
    }
    print("Selected curve index: \(selectedArcIndex)")
    insertCurve(afterIndex: selectedArcIndex, undoManager: undoManager)
  }

  private func insertCurve(afterIndex index: Int, undoManager: UndoManager? = nil) {
    let newCurve = CurveDefinition()
    let insertionIndex = index + 1
    if picdef.curves.indices.contains(insertionIndex) {
      picdef.curves.insert(newCurve, at: insertionIndex)
      selectedCurveIndex = insertionIndex
      selectedDotIndex = nil
      registerUndoForInsertCurve(atIndex: insertionIndex, undoManager: undoManager)
    } else {
      print("Error: Invalid index \(insertionIndex). Curve not added.")
    }
  }

  private func registerUndoForInsertCurve(atIndex index: Int, undoManager: UndoManager?) {
    let count = self.picdef.curves.count
    undoManager?.registerUndo(withTarget: self) { doc in
      withAnimation {
        doc.deleteCurve(atIndex: count - 1, undoManager: undoManager)
      }
    }
  }

  func deleteCurve(undoManager: UndoManager? = nil) {
    print("Called Clear (Delete) Curve")
    guard let selectedArcIndex = selectedCurveIndex else {
      print("Error: No curve selected for deletion.")
      return
    }
    print("Selected curve index: \(selectedArcIndex)")
    deleteCurve(atIndex: selectedArcIndex, undoManager: undoManager)
  }

  private func deleteCurve(atIndex index: Int, undoManager: UndoManager?) {
    let oldCurves = self.picdef.curves
    if picdef.curves.indices.contains(index) {
      picdef.curves.remove(at: index)
      selectedCurveIndex = nil
      selectedDotIndex = nil
      registerUndoForDeleteCurve(oldCurves: oldCurves, undoManager: undoManager)
    } else {
      print("Error: Invalid index \(index). Curve not deleted.")
    }
  }

  private func registerUndoForDeleteCurve(oldCurves: [CurveDefinition], undoManager: UndoManager?) {
    undoManager?.registerUndo(withTarget: self) { doc in
      doc.replaceCurves(with: oldCurves, undoManager: undoManager)
    }
  }

  // Replaces the curves and registers an undo action.
  func replaceCurves(with newCurves: [CurveDefinition], undoManager: UndoManager? = nil, animation: Animation? = .default) {
    let oldCurves = self.picdef.curves
    withAnimation(animation) {
      picdef.curves = newCurves
    }
    registerUndoForReplaceCurves(oldCurves: oldCurves, undoManager: undoManager, animation: animation)
  }

  private func registerUndoForReplaceCurves(oldCurves: [CurveDefinition], undoManager: UndoManager?, animation: Animation?) {
    undoManager?.registerUndo(withTarget: self) { doc in
      doc.replaceCurves(with: oldCurves, undoManager: undoManager, animation: animation)
    }
  }

}
