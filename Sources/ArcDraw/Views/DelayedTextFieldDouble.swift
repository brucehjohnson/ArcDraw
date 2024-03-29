import SwiftUI

@available(macOS 11.0, *)
struct DelayedTextFieldDouble: View {
  var title: String?
  var placeholder: String
  @Binding var value: Double
  var formatter: NumberFormatter
  var onCommit: () -> Void

  @State private var stringValue: String

  init(title: String? = nil, placeholder: String, value: Binding<Double>, formatter: NumberFormatter, onCommit: @escaping () -> Void = {}) {
    self.title = title
    self.placeholder = placeholder
    self._value = value
    self.formatter = formatter
    self.onCommit = onCommit
    self._stringValue = State(initialValue: formatter.string(from: NSNumber(value: value.wrappedValue)) ?? "")
  }

  var body: some View {
    VStack {
      if let title = title {
        Text(title)
      }
      TextField(placeholder, text: $stringValue, onEditingChanged: { isEditing in
        if !isEditing {
          // Convert string to double only on editing completion
          if let num = formatter.number(from: stringValue) {
            value = num.doubleValue
            onCommit()
          }
        }
      })
      .onChange(of: value) { newValue in
        // Update stringValue with formatted string
        stringValue = formatter.string(from: NSNumber(value: newValue)) ?? ""
      }
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .multilineTextAlignment(.trailing)
    }
    .onAppear {
      stringValue = formatter.string(from: NSNumber(value: value)) ?? ""
    }
  }
}
