import Foundation

struct ADFormatters {

  private static func createCommaFormatter(maxFractionDigits: Int, min: NSNumber? = nil, max: NSNumber? = nil) -> NumberFormatter {
    let formatter = CommaNumberFormatter()
    formatter.maximumFractionDigits = maxFractionDigits
    formatter.minimum = min
    formatter.maximum = max
    return formatter
  }

  // USER INPUT CUSTOM FORMATTERS - BASIC  .........................

  static var fmtImageWidthHeight: NumberFormatter {
    return createCommaFormatter(maxFractionDigits: 0, min: 1, max: 100_000)
  }

  static var fmtXY: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.isPartialStringValidationEnabled = true
    formatter.maximumFractionDigits = 17
    formatter.maximum = 2.0
    formatter.minimum = -2.0
    return formatter
  }

  static var fmtRotationTheta: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 1
    formatter.minimum = -359.9
    formatter.maximum = 359.9
    return formatter
  }

  static var fmtIntColorOrderNumber: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 8
    return formatter
  }

  static var fmt0to255: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0
    formatter.minimum = 0
    formatter.maximum = 255
    return formatter
  }

}
