import SwiftUI

class AppState: ObservableObject {
  @Published var shouldShowWelcomeWhenStartingUp: Bool = UserDefaults.standard.object(forKey: "shouldShowWelcomeWhenStartingUp") as? Bool ?? true

  @Published var showingWelcome: Bool = UserDefaults.standard.object(forKey: "shouldShowWelcomeWhenStartingUp") as? Bool ?? true

  @Published var gMenuItem: Int = 0
  @Published var gLastMenuItem: Int = 0
  @Published var gAngleClick: Int = 0
  @Published var gAddDotClick: Int = 0
  @Published var gHighCurveNum: Int = -1
  @Published var gCurveNum: Int = 0
  @Published var gOldDotLoc: CGPoint = CGPoint.zero
  @Published var gOldAppleAngle: Double = 0.0
  @Published var gAppleAngle: Double = 0.0
  @Published var gHighDotNum: [Int] = [Int](repeating: -1, count: 21)

  @Published var gSecondAngleFlag: Bool = false
  @Published var gSketchFlag: Bool = false
  @Published var gUndoFlag: Bool = false
  @Published var gHighCurveNumFlag: Bool = false
  @Published var gAngleFlag: [Bool] = [Bool](repeating: false, count: 21)

  @Published var gDragFlag: Bool = false
  @Published var gShowDots: Int = 1

  @Published var gDotSelectIndex: Int = 0
  @Published var gDeleteDotIndex: Int = 0
  @Published var gDragDotIndex: Int = 0
  @Published var gAddDotIndex: Int = 0
  @Published var gOldAngleIndex: Int = 0
  @Published var gAngleIndex: [Int] = [Int](repeating: 0, count: 21)
  @Published var gAngleIndexAfter: Int = 0
  @Published var gAngleIndexBefore: Int = 0

  @Published var gX: [Int] = [Int](repeating: 0, count: 301)
  @Published var gY: [Int] = [Int](repeating: 0, count: 301)
  @Published var gAlphai: [Double] = [Double](repeating: 0.0, count: 301)
  @Published var gAlphaf: [Double] = [Double](repeating: 0.0, count: 301)
  @Published var gStartAngle: [Double] = [Double](repeating: 0.0, count: 301)
  @Published var gArcAngle: [Double] = [Double](repeating: 0.0, count: 301)
  @Published var gXc: [Double] = [Double](repeating: 0.0, count: 301)
  @Published var gYc: [Double] = [Double](repeating: 0.0, count: 301)
  @Published var gR: [Double] = [Double](repeating: 0.0, count: 301)
  @Published var gDotLoc: [CGPoint] = [CGPoint](repeating: CGPoint.zero, count: 301)
  @Published var gDotRegion: [CGMutablePath] = [CGMutablePath](repeating: CGMutablePath(), count: 301)



}
