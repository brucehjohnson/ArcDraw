import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawApp {

  // App has:
  //   @ObservedObject var doc: ArcDrawDocument = ArcDrawDocument()

  // Document has:
  //  @Published var picdef: PictureDefinition
  //  @Published var selectedArcIndex: Int?
  //  @Published var selectedDotIndex: Int?

  func appMenuCommands() -> some Commands {
    Group {
      // Disable "New Window" option
      // CommandGroup(replacing: .newItem) {}

      CommandMenu("Draw") {

        Button("New Curve") {
          print("Called New Curve")

          if let selectedArcIndex = doc.selectedCurveIndex {
            print("Selected curve index: \(selectedArcIndex)")
            doc.addCurveAfter(atCurveIndex: selectedArcIndex)
          } else {
            let lastCurveIndex = doc.picdef.curves.count - 1
            if lastCurveIndex >= 0 {
              print("No curve selected. Adding a new curve after the last one.")
              doc.addCurveAfter(atCurveIndex: lastCurveIndex)
            } else {
              print("No curves available. Adding a new curve at the beginning.")
              doc.picdef.curves.insert(CurveDefinition(), at: 0)
              doc.selectedCurveIndex = 0
            }
          }
        }


        Button("Clear Curve") {
          print("Called Clear Curve")

          if let selectedArcIndex = doc.selectedCurveIndex {
            print("Selected curve index: \(doc.selectedCurveIndex!)")
            doc.deleteCurve(atArcIndex: selectedArcIndex)
          }
        }


        Button("Add Dot Before") {
          print("Called Add Dot Before")

          if let selectedArcIndex = doc.selectedCurveIndex {
            print("Curve index is available.")

            if let selectedDotIndex = doc.selectedDotIndex {
              print("Dot index is available.")
              print("Selected curve index: \(selectedArcIndex)")
              print("Selected dot index: \(selectedDotIndex)")

              // Perform action here (doc.addDotBefore)
            } else {
              print("Dot index is missing.")
            }
          } else {
            print("Curve index is missing.")
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Add Dot After") {
          print("Called Add Dot After")

          if let selectedArcIndex = doc.selectedCurveIndex {
            print("Curve index is available.")

            if let selectedDotIndex = doc.selectedDotIndex {
              print("Dot index is available.")
              print("Selected curve index: \(selectedArcIndex)")
              print("Selected dot index: \(selectedDotIndex)")

              // Perform action here (doc.addDotAfter)
            } else {
              print("Dot index is missing.")
            }
          } else {
            print("Curve index is missing.")
          }
        }
        .disabled(doc.selectedCurveIndex == nil)

        Button("Delete Dot") {
          print("Called Delete Dot")

          if let selectedCurveIndex = doc.selectedCurveIndex {
            print("Curve index is available.")

            if let selectedDotIndex = doc.selectedDotIndex {
              print("Dot index is available.")
              print("Selected curve index: \(selectedCurveIndex)")
              print("Selected dot index: \(selectedDotIndex)")

              // Perform action here (doc.deleteDot)
            } else {
              print("Dot index is missing.")
            }
          } else {
            print("Curve index is missing.")
          }
        }
        .disabled(doc.selectedCurveIndex == nil)



        Button("Drag Dot") {
          print("Called Drag Dot")

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

      //=====================================================

      CommandMenu("Examples") {

        Button("Cursive") {
          simulateTabKeyPress()
          doc.loadExampleJSONAndUpdate("cursive")
        }


        Button("Hearts") {
          simulateTabKeyPress()
          doc.loadExampleJSONAndUpdate("hearts")
        }


        Button("Moons") {
          simulateTabKeyPress()
          doc.loadExampleJSONAndUpdate("moons")
        }


        Button("Petals") {
          simulateTabKeyPress()
          doc.loadExampleJSONAndUpdate("petals")
        }

        Button("Shapes") {
          simulateTabKeyPress()
          doc.loadExampleJSONAndUpdate("shapes")
        }


        Button("Spirals") {
          simulateTabKeyPress()
          doc.loadExampleJSONAndUpdate("spirals")
        }


        Button("YinYang") {
          simulateTabKeyPress()
          doc.loadExampleJSONAndUpdate("yinyang")
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


