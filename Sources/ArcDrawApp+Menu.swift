import SwiftUI

@available(macOS 12.0, *)
extension ArcDrawApp {


  func appMenuCommands() -> some Commands {
    Group {
      // Disable "New Window" option
      // CommandGroup(replacing: .newItem) {}

      CommandMenu("Draw") {
        Button("New Curve"){}
        Button("Define Direction"){}
        Button("Delete Dot"){}
        Button("Clear Curve"){}
        Button("Drag Dot"){}
        Button("Add Dot Before"){}
        Button("Add Dot After"){}
        Button("New Sketch Curve"){}
      }

      CommandMenu("Examples") {
        Button("Cursive") {
          print("Clicked Cursive Example")
          doc.loadExampleJSONAndUpdate("cursive")

        }
        Button("Hearts") {
          print("Clicked Hearts Example")

          doc.loadExampleJSONAndUpdate("hearts")

        }
        Button("Moons") {
          print("Clicked Moons Example")

          doc.loadExampleJSONAndUpdate("moons")

        }
        Button("Petals") {
          print("Clicked Petals Example")

          doc.loadExampleJSONAndUpdate("petals")

        }
        Button("Shapes") {
          print("Clicked Shapes Example")

          doc.loadExampleJSONAndUpdate("shapes")

        }
        Button("Spirals") {
          print("Clicked Spirals Example")

          doc.loadExampleJSONAndUpdate("spirals")

        }
        Button("YinYang") {
          print("Clicked YinYang Example")

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

      
    }
  }

  

}
