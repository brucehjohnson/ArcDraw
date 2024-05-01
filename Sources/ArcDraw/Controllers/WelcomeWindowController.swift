import SwiftUI
import AppKit

class WelcomeWindowController: NSWindowController {

  var appState: AppState

  init(appState: AppState) {
    self.appState = appState
    let width = AppConstants.defaultWidth()
    let height = AppConstants.defaultHeight()
    let minW = AppConstants.minWelcomeWidth
    let minH = AppConstants.minWelcomeHeight
    let maxW = AppConstants.maxWelcomeWidth()
    let maxH = AppConstants.maxWelcomeHeight()

    let window = NSWindow(
      contentRect: NSRect(
        x: 0, y: 0,
        width: width,
        height: height
      ),
      styleMask: [.titled, .closable, .resizable],
      backing: .buffered, defer: false)

    super.init(window: window)

    window.center()
    window.setFrameAutosaveName("Welcome Window")
    window.minSize = NSSize(width: minW, height: minH)
    window.maxSize = NSSize(width: maxW, height: maxH)

    window.contentView = NSHostingView(rootView: WelcomeView().environmentObject(self.appState))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
