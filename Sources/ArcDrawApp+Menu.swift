import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawApp {

  func appMenuCommands() -> some Commands {
    Group {
      // Disable "New Window" option
      // CommandGroup(replacing: .newItem) {}

      CommandMenu("Draw") {

        Button("New Curve") {
          doc.addNewCurve()
        }

        Button("Clear Curve") {
          doc.deleteCurve()
        }

        Button("Add Dot Before") {
          if let selectedCurveIndex = doc.selectedCurveIndex {
            doc.picdef.curves[selectedCurveIndex].addDotBefore(selectedDotIndex: doc.selectedDotIndex)
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Add Dot After") {
          if let selectedCurveIndex = doc.selectedCurveIndex {
            doc.picdef.curves[selectedCurveIndex].addDotAfter(selectedDotIndex: doc.selectedDotIndex)
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Delete Dot") {
          if let selectedCurveIndex = doc.selectedCurveIndex {
            doc.picdef.curves[selectedCurveIndex].deleteSelectedDot(selectedDotIndex: doc.selectedDotIndex)
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Drag Dot") {
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


