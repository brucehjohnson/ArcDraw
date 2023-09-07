import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawApp {

  func appMenuCommands() -> some Commands {
    Group {
      // Disable "New Window" option
      // CommandGroup(replacing: .newItem) {}

      CommandMenu("Draw") {

        Button("New Curve") {
          print("Clicked Add New Curve MENU Button")
          doc.handleAddNewCurveRequest()
         }
        .disabled(doc.isReadOnly)


        Button("Clear Curve") {
          print("Clicked Clear Curve MENU Button")

          doc.deleteCurve()
        }
        .disabled(doc.isReadOnly)


        Button("Add Dot Before") {
          print("Clicked Add Dot Before MENU Button")

          if let selectedCurveIndex = doc.selectedCurveIndex {
            doc.picdef.curves[selectedCurveIndex].addDotBefore(selectedDotIndex: doc.selectedDotIndex)
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Add Dot After") {
          print("Clicked Add Dot After MENU Button")

          if let selectedCurveIndex = doc.selectedCurveIndex {
            doc.picdef.curves[selectedCurveIndex].addDotAfter(selectedDotIndex: doc.selectedDotIndex)
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Delete Dot") {
          print("Clicked Delete Dot MENU Button")

          if let selectedCurveIndex = doc.selectedCurveIndex {
            doc.picdef.curves[selectedCurveIndex].deleteSelectedDot(selectedDotIndex: doc.selectedDotIndex)
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Drag Dot") {
          print("Clicked Drag Dot MENU Button")

          if let selectedCurveIndex = doc.selectedCurveIndex,
             let selectedDotIndex = doc.selectedDotIndex {
            doc.picdef.curves[selectedCurveIndex].moveDot(from: selectedDotIndex, to: 0) // You can change the destinationIndex as needed
          }
        }
        .disabled(doc.selectedCurveIndex == nil || doc.selectedDotIndex == nil)


        Button("Define Direction") {
          print("Called Define Direction")

          if let selectedCurveIndex = doc.selectedCurveIndex {
            print("Selected curve index: \(selectedCurveIndex)")

            if let selectedDotIndex = doc.selectedDotIndex {
              print("Selected dot index: \(selectedDotIndex)")
            } else {
              print("Missing selected dot index")
            }
          } else {
            print("Missing selected curve index")
          }
        }
        .disabled(doc.selectedCurveIndex == nil)


        Button("New Sketch Curve"){
          print("Called New Sketch Curve ")

        }
      }

      CommandMenu("Examples") {
        let exampleOptions = ["Cursive", "Hearts", "Moons", "Petals", "Shapes", "Spirals", "YinYang"]
        ForEach(exampleOptions, id: \.self) { example in
          Button(example) {
            selectedExample = example
            simulateTabKeyPress()
            doc.loadExampleJSONAndUpdate(example)
          }
        }
      }


      CommandMenu("Welcome") {
        Button("Show Welcome Screen") {
          let controller = WelcomeWindowController(appState: self.appState)
          controller.showWindow(self)
          controller.window?.makeKeyAndOrderFront(nil)
        }
      }

      // we don't need the Edit/pasteboard menu item (cut/copy/paste/delete)
      // so we'll replace it with nothing
      CommandGroup(replacing: CommandGroupPlacement.pasteboard) {}

      // Help has "Search" & "ArcDraw Help" by default
      // let's replace the ArcDraw help option with a Link
      // to our hosted documentation on GitHub Pages
      let displayText: String = "ArcDraw Help"
      let url: URL = .init(string: "https://denisecase.github.io/MandArt-Docs/documentation/mandart/")!
      CommandGroup(replacing: CommandGroupPlacement.help) {
        Link(displayText, destination: url)
      }
    } // group
  }

}


