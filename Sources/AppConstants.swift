import SwiftUI

internal struct AppConstants {
  static let defaultOpeningWidth: CGFloat = 800.0
  static let defaultOpeningHeight: CGFloat = 600.0
  static let defaultPercentWidth: CGFloat = 0.8
  static let defaultPercentHeight: CGFloat = 0.8
  static let dockAndPreviewsWidth: CGFloat = 200.0
  static let minWelcomeWidth: CGFloat = 500.0
  static let minWelcomeHeight: CGFloat = 500.0
  static let heightMargin: CGFloat = 50.0

  internal static func defaultWidth() -> CGFloat {
    if let screenWidth = NSScreen.main?.visibleFrame.width {
      return min(screenWidth * defaultPercentWidth, screenWidth - dockAndPreviewsWidth)
    }
    return defaultOpeningWidth
  }

  internal static func defaultHeight() -> CGFloat {
    if let screenHeight = NSScreen.main?.visibleFrame.height {
      return screenHeight * defaultPercentHeight
    }
    return defaultOpeningHeight
  }

  internal static func maxWelcomeWidth() -> CGFloat {
    if let screenWidth = NSScreen.main?.visibleFrame.width {
      return screenWidth * 0.66
    }
    return minWelcomeWidth
  }

  internal static func maxWelcomeHeight() -> CGFloat {
    if let screenHeight = NSScreen.main?.visibleFrame.height {
      return screenHeight * 0.8
    }
    return minWelcomeHeight
  }

  internal static func maxDocumentWidth() -> CGFloat {
    if let screenWidth = NSScreen.main?.visibleFrame.width {
      return screenWidth - dockAndPreviewsWidth
    }
    return defaultOpeningWidth
  }

  internal static func maxDocumentHeight() -> CGFloat {
    if let screenHeight = NSScreen.main?.visibleFrame.height {
      return screenHeight - heightMargin
    }
    return defaultOpeningHeight
  }
}
