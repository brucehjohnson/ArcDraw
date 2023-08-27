

/***************************************************************
 RoundToInt
 **************************************************************

 Round Double number to integer.

 Receives: Double number
 Changes: number into best integer approximation
 Returns: integer number
 */

import Foundation // ceil

func roundToInt(number: Double) -> Int {
  var intNumber: Int = 0  // resulting integer
  var absNumber: Double = 0
  var ceilNumber: Int  // ceil() returns a double; we convert to int
  var delta: Double = 0

  absNumber = abs(number)
  ceilNumber = Int(ceil(absNumber))
  delta = Double(ceilNumber) - absNumber

  if delta < 0.5 {
    intNumber = ceilNumber
  }

  if delta > 0.5 {
    intNumber = ceilNumber - 1
  }

  if delta == 0.5 {
    if (ceilNumber - 1) % 2 > 0 {  // % means modulus
      intNumber = ceilNumber
    } else {
      intNumber = ceilNumber - 1
    }
  }

  if number < 0 {
    intNumber = -intNumber
  }

  return intNumber
}
