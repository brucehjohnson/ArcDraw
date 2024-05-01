import SwiftUI
import AppKit
import Foundation
import UniformTypeIdentifiers
import CoreGraphics

@available(macOS 12.0, *)
struct ContentView: View {

  @EnvironmentObject var appState: AppState
  @Binding var selectedExample: String
  @Binding var showAlert: Bool
  @Binding var alertMessage: String
  @Binding var showReadOnlyAlert: Bool

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }


  let widthOfInputPanel: Double = 400

      var body: some View {
          GeometryReader { _ in
            HStack(alignment: .top, spacing: 0) {

              PanelUI(selectedExample: $selectedExample)
                .frame(width: widthOfInputPanel > 0 ? widthOfInputPanel : 400)

              PanelDisplay(selectedExample: $selectedExample)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            } // hstack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.leading, 0)

          } // geo
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .onAppear {
            print("Document accessed from ContentView: \(Unmanaged.passUnretained(doc).toOpaque())")

          }
          .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
          }
          .alert(isPresented: $showReadOnlyAlert) {
            Alert(title: Text("Read-Only Document"),
                  message: Text("This is a read-only example. Would you like to save your edits as a new document?"),
                  primaryButton: .default(Text("Save As New"), action: {
              doc.saveDocumentAsNew()
            }),
                  secondaryButton: .cancel())
          }

        } // body

   }

/* DMC


 /*     // Assuming you have a CGPathRef called 'regionPath' representing your region

CGPoint clickPoint = [event locationInWindow]; // Get the mouse click point
clickPoint = [myView convertPoint:clickPoint fromView:nil]; // Convert the point to the view's coordinate system

if (CGPathContainsPoint(regionPath, NULL, clickPoint, NO)) {
    // The click is inside the region
    // Perform your desired action here
} else {
    // The click is outside the region
} */
      
      var gMouseDown = false
      var gMouseMove = false
      
      var gPi: Double
      var gDegToRad: Double
      var gRadToDeg: Double
      
      var gxClient: Int
      var gyClient: Int
      
      var gMousex: Int
      var gMousey: Int
      
      var gPtIsInARegion: Bool
      
      var gSketchClick: Int
      var gArcLength: Int
      var gLastMouse: CGPoint
      var gAngleFlag2: Bool
      var gAnglePoint2: CGPoint
      var gAlpha1: Double
      var gU = [Double](repeating: 0.0, count: 15)
      var gUt0: Double
      var gUt1: Double
      var gUt2: Double
      var gEnergyFlag: Bool
      
      var gIsCW = [Bool](repeating: false, count: 301)
    
   
    }
}
*/ // DENISE DMC COMMENTED OUT
