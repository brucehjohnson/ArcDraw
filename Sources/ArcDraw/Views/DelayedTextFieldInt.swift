import SwiftUI

@available(macOS 11.0, *)
struct DelayedTextFieldInt: View {

  @State private var inputValue: String

  @Binding var value: Int

  var title: String?
  var placeholder: String
  var formatter: NumberFormatter
  var onCommit: () -> Void

  init(title: String? = nil, placeholder: String, value: Binding<Int>, formatter: NumberFormatter, onCommit: @escaping () -> Void = {}) {
    self.title = title
    self.placeholder = placeholder
    self.formatter = formatter
    self.onCommit = onCommit
    self._value = value
    self._inputValue = State(initialValue: "\(value.wrappedValue)")
  }

  var body: some View {
    VStack {
      if let title = title {
        Text(title)
      }
      TextField(
        placeholder,
        text: $inputValue // Use string binding
      )
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .multilineTextAlignment(.trailing)
      .onChange(of: inputValue) { newValue in
        // Convert string input value to Int and update the binding after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          if let intValue = formatter.number(from: newValue)?.intValue {
            value = intValue
            onCommit()
          }
        }
      }
    }
  }
}
