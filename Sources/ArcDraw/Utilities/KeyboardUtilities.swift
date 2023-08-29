import SwiftUI

func simulateTabKeyPress() {
  let source = CGEventSource(stateID: .hidSystemState)

  let tabDown = CGEvent(keyboardEventSource: source, virtualKey: 0x30, keyDown: true) // 0x30 is the virtual key code for TAB
  let tabUp = CGEvent(keyboardEventSource: source, virtualKey: 0x30, keyDown: false)

  tabDown?.post(tap: .cghidEventTap)
  tabUp?.post(tap: .cghidEventTap)
}
