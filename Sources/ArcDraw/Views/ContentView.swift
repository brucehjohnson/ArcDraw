//
//  ContentView.swift
//  ArcDraw
//
//  Created by Bruce Johnson on 7/19/23.
//

import SwiftUI
import AppKit
import Foundation
import UniformTypeIdentifiers
import CoreGraphics

@available(macOS 12.0, *)
struct ContentView: View {

  @EnvironmentObject var appState: AppState
  @ObservedObject var doc: ArcDrawDocument

  let widthOfInputPanel: Double = 400

      var body: some View {
          GeometryReader { _ in
            HStack(alignment: .top, spacing: 0) {
              PanelUI(doc: doc)
                .frame(width: widthOfInputPanel > 0 ? widthOfInputPanel : 400)

              PanelDisplay(doc: doc)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } // hstack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.leading, 0)

          } // geo
          .frame(maxWidth: .infinity, maxHeight: .infinity)

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
