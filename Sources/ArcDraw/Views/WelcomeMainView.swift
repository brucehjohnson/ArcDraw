import SwiftUI
import AppKit

@available(macOS 11.0, *)
struct WelcomeMainView: View {

  @EnvironmentObject var appState: AppState

  var body: some View {
    GeometryReader { geometry in
      let availableHeight = geometry.size.height
      let  imageHeight = availableHeight * Constants.imageHeightFactor
      let descriptionHeight = availableHeight * Constants.descriptionHeightFactor

      VStack(spacing: 0) {
        WelcomeMainImageView()
          .frame(height: imageHeight / 1.5)
        WelcomeMainInformationView(showWelcomeScreen: appState.shouldShowWelcomeWhenStartingUp)
          .frame(height: descriptionHeight)
          .padding()
      }
    }
  }
}
