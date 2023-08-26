//
//  ContentView.swift
//  ArcDraw
//
//  Created by Bruce Johnson on 7/19/23.
//

import SwiftUI


@available(macOS 12.0, *)
struct ContentView: View {


  @EnvironmentObject var appState: AppState
  @ObservedObject var doc: ArcDrawDocument


  let widthOfInputPanel: Double = 400


    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

