/***************************************************************
 calcArcs
 **************************************************************

 This fills in the rest of the arrays so we can draw the arcs.

 Requires:
 Receives: nothing
 Changes: global arrays
 Returns: nothing
 */

/*
func calcArcs()
{
  var i: Int
  var j: Int
  var k: Int
  var n: Int
  var x1: Double
  var x2: Double
  var y1: Double
  var y2: Double
  var e: Double
  var d: Double
  var f: Double
  var d11: Double
  var d12: Double
  var d21: Double
  var d22: Double
  var thetat: Double
  var y1t: Double
  var yCt: Double
  var xRef: Double
  var yRef: Double
  var isCW: Bool
  var initialAngleIndex: Int
  var highAngleIndex: Int
  var initialDotIndex: Int
  var highDotIndex: Int
  var eNum = 0.0
  var eDenom = 0.0
  var d11Flag: Bool
  var d21Flag: Bool
  var d12Flag: Bool
  var d22Flag: Bool
  var d12Num: Double
  var d12Denom: Double
  var d11Num: Double
  var d11Denom: Double
  //     var dummy: Int
  var alpha12: Double
  var dAlpha12: Double
  var startAngle: Double
  var arcAngle: Double
  var alphaiT: Double
  var r1Deg: Double

  var curveNum: Int

  curveNum = gCurveNum

  /*  Any index must have range of 0 - 299  */

  /*  Any number must have range of 0 - 19  */

  initialAngleIndex = gAngleIndex[gCurveNum]

  /*  We have one less arc than we have dots in a curve  */
  highAngleIndex = 15*gCurveNum + gHighDotNum[gCurveNum] - 1

  gAlphai[initialAngleIndex] = 90.0 - gAppleAngle

  if gAlphai[initialAngleIndex] < 0 {
    gAlphai[initialAngleIndex] = gAlphai[initialAngleIndex] + 360.0}
  /*  gAlphai[ ] is a double, 0.0 to 360.0, CW from x direction  */

  initialDotIndex = 15*gCurveNum
  highDotIndex = initialDotIndex + gHighDotNum[gCurveNum]

  /*  find all gX's and gY's for the curve  */
  var ii = initialDotIndex
  while ii <= highDotIndex  {
    gX[ii] = Int(gDotLoc[ii].x)
    gY[ii] = Int(-gDotLoc[ii].y)
    ii = ii+1
  }

  /*      for ( i = initialDotIndex;  i <= highDotIndex;  i+= )
   {
   gX[i] = gDotLoc[i].x
   gY[i] = -gDotLoc[i].y
   } */

  /*  Find parameters of initial arc  */
  x1 = Double(gX[initialAngleIndex])
  x2 = Double(gX[initialAngleIndex + 1])
  y1 = Double(gY[initialAngleIndex + 0])
  y2 = Double(gY[initialAngleIndex + 1])

  alpha12 = gRadToDeg*atan2(y2 - y1, x2 - x1)

  if alpha12 < 0.0 {
    alpha12 = alpha12 + 360.0  //  To get in range of 0.0 to 360.0
  }

  dAlpha12 = gAlphai[initialAngleIndex] - alpha12;

  if dAlpha12 < 0 {
    dAlpha12 = dAlpha12 + 360.0 }  //  To get in range of 0.0 to 360.0

  if dAlpha12 == 0.0 {
    gR[initialAngleIndex] = 15000.0 }  //  To get one line

  else if dAlpha12 == 180.0 {
    gR[initialAngleIndex] = 16000.0 }  //  To get two lines

  else {
    /*  Determine if initial arc is CW  */

    if dAlpha12 < 180.0 {
      gIsCW[ gAngleIndex[gCurveNum] ] = true
      isCW = true
    }

    else {
      gIsCW[ gAngleIndex[gCurveNum] ] = false
      isCW = false
    }

    /*  Find start angle of initial arc  */
    if isCW {
      startAngle = -gAlphai[initialAngleIndex] }

    else
    {
  startAngle = 180.0 - gAlphai[initialAngleIndex]

  if startAngle < 0.0 {
    startAngle = startAngle + 360.0 }
    }

    gStartAngle[initialAngleIndex] = startAngle

    /*  Find a truncated alphai for finding arc angle of initial arc  */
    if isCW {
      alphaiT = -gStartAngle[initialAngleIndex] }

    else
    {
  alphaiT = 180.0 - gStartAngle[initialAngleIndex]

  if alphaiT < 0.0 {
    alphaiT = alphaiT + 360.0 }
    }

    /*  Find gXc, gYc, and gR for initial arc  */
    if gAlphai[initialAngleIndex] == 90.0 {
      d11 = 1000000.0 }

    else if gAlphai[initialAngleIndex] == 270.0 {
      d11 = -1000000.0 }

    else {
      d11 = tan(gDegToRad*gAlphai[initialAngleIndex]) }

    /*  We don't need d11Flag or d21Flag because we know gAlphai  */

    e = ( x1*x1 - y1*y1 + x2*x2 + y2*y2 - 2*x1*x2 + 2*d11*y1*(x1 - x2) )
    / ( d11*(x2 - x1) + y1 - y2 )
    d = -2*(x1 + d11*y1) - d11*e
    f = -x1*(d + x1) - y1*(e + y1)

    gXc[initialAngleIndex]   = -d/2
    gYc[initialAngleIndex]   = -e/2
    gR[initialAngleIndex]   = sqrt(d*d/4 + e*e/4 - f)

    r1Deg = 57.3*sqrt( (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) )

    if gR[initialAngleIndex] > r1Deg || gR[initialAngleIndex] > 14999.0
    {
  gXc[initialAngleIndex] = 0.0
  gYc[initialAngleIndex] = 0.0

  if fabs(dAlpha12 - 180.0) < 10.0 {
    gR[initialAngleIndex] = 16000.0 }  //  To get two lines

  else {
    gR[initialAngleIndex] = 15000.0}  //  To get one line
    }
  }

  /*  Find gAlphaf[initialAngleIndex] for initial arc  */

  if dAlpha12 == 0.0 || dAlpha12 == 180.0 {
    gAlphaf[initialAngleIndex] = gAlphai[initialAngleIndex] }

  else {
    d12Num    = -(2*x2 + d)
    d12Denom  = (2*y2 + e)

    if d12Denom == 0 && isCW {
      gAlphaf[initialAngleIndex] = 90.0 }

    else if d12Denom == 0 && !isCW {
      gAlphaf[initialAngleIndex] = 270.0 }

    else {
      d12 = d12Num/d12Denom
      if d12 > 0 {
        d12Flag = true }

      else {
        d12Flag = false }

      d22 = d12*(2*x2 + d) - 2*y2 - e

      if d22 > 0 {
        d22Flag = true }

      else {
        d22Flag = false }

      xRef = 1.0
      yRef = fabs(d12)

      gAlphaf[initialAngleIndex] = gRadToDeg*atan2(yRef, xRef)  /*  In range of 0.0 - 90.0  */

      if d12Flag {
        if d22Flag && !isCW || !d22Flag && isCW {
          gAlphaf[initialAngleIndex] = gAlphaf[initialAngleIndex] }

        else {
          gAlphaf[initialAngleIndex] = gAlphaf[initialAngleIndex] + 180.0 }

      }



      else
      {
    if (d22Flag && isCW) || (!d22Flag && !isCW) {
      gAlphaf[initialAngleIndex] = 180.0 - gAlphaf[initialAngleIndex] }

    else {
      gAlphaf[initialAngleIndex] = 360.0 - gAlphaf[initialAngleIndex] }

      }


      /*  Find arc angle for initial arc  */
      arcAngle = alphaiT - gAlphaf[initialAngleIndex]

      if isCW && arcAngle < 0 {
        arcAngle = arcAngle + 360.0 }

      if !isCW && arcAngle > 0 {
        arcAngle = arcAngle - 360.0 }
    }
  }

  gArcAngle[initialAngleIndex] = arcAngle


  /*   find parameters above initialAngleIndex   */
  for ( j = initialAngleIndex + 1;  j <= highAngleIndex;  j+= )
  {
x1 = gX[j]
x2 = gX[j + 1]
y1 = gY[j]
y2 = gY[j + 1]

gAlphai[j] = gAlphaf[j - 1]

alpha12 = gRadToDeg*atan2(y2 - y1, x2 - x1)

if alpha12 < 0 {
  alpha12 = alpha12 + 360.0 }  /*  To get in range of 0 to 359  */

dAlpha12 = gAlphai[j] - alpha12

if dAlpha12 < 0.0 {
  dAlpha12 = dAlpha12 + 360.0 }  /*  To get in range of 0 to 359  */

if dAlpha12 == 0.0 {
  gR[j] = 15000.0 }  /*  To get one line  */

else if dAlpha12 == 180.0 {
  gR[j] = 16000.0 }  /*  To get two lines  */

else {
  /*  Determine if arc is CW  */
  if dAlpha12 < 180.0 {
    gIsCW[j] = 1
    isCW = 1
  }

  else {
    gIsCW[j] = 0
    isCW = 0 }

  /*  Find start angle  */
  if isCW {
    startAngle = -gAlphai[j] }

  else {
    startAngle = 180.0 - gAlphai[j]
    if startAngle < 0.0 {
      startAngle = startAngle + 360.0 }
  }

  gStartAngle[j] = startAngle

  /*  Find a truncated alphai for finding arc angle  */
  if isCW {
    alphaiT = -gStartAngle[j] }

  else {
    alphaiT = 180.0 - gStartAngle[j]
    if alphaiT < 0.0 {
      alphaiT = alphaiT + 360.0 }
  }

  /*  Find gXc, gYc, and gR  */
  if gAlphai[j] == 90.0 {
    d11 = 1000000.0 }

  else if gAlphai[j] == 270.0 {
    d11 = -1000000.0}

  else {
    d11 = tan(gDegToRad*gAlphai[j]) }

  /*  We don't need d11Flag or d21Flag because we know gAlphai  */

  e = ( x1*x1 - y1*y1 + x2*x2 + y2*y2 - 2*x1*x2 + 2*d11*y1*(x1 - x2) )
  /( d11*(x2 - x1) + y1 - y2 )
  d = -2*(x1 + d11*y1) - d11*e
  f = -x1*(d + x1) - y1*(e + y1)

  gXc[j] = -d/2
  gYc[j] = -e/2
  gR[j] = sqrt(d*d/4 + e*e/4 - f)

  r1Deg = 57.3*sqrt( (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) )

  if gR[j] > r1Deg || gR[j] > 14999.0 {
    gXc[j] = 0.0
    gYc[j] = 0.0

    if fabs(dAlpha12 - 180.0) < 10.0 {
      gR[j] = 16000.0 }  /*  To get two lines  */

    else {
      gR[j] = 15000.0 }  /*  To get one line  */

  }

}    //  End else

/*  Find gAlphaf[ ]  */

if dAlpha12 == 0.0 || dAlpha12 == 180.0 {
  gAlphaf[initialAngleIndex] = gAlphai[initialAngleIndex] }

else {
  d12Num    = -(2*x2 + d)
  d12Denom  = (2*y2 + e)

  if d12Denom == 0.0 && isCW {
    gAlphaf[j] = 90.0 }

  else if d12Denom == 0 && !isCW {
    gAlphaf[j] = 270.0 }

  else {
    d12 = d12Num/d12Denom

    if d12 >= 0 {
      d12Flag = true }

    else {
      d12Flag = false }

    d22 = d12*(2*x2 + d) - 2*y2 - e

    if d22 > 0 {
      d22Flag = true }

    else {
      d22Flag = false }

    xRef = 1.0
    yRef = fabs(d12)

    gAlphaf[j] = gRadToDeg*atan2(yRef, xRef)  /*  In range of 0.0 - 90.0  */

    if d12Flag {
      if (d22Flag && !isCW) || (!d22Flag && isCW) {

        gAlphaf[j] = gAlphaf[j] }

      else {
        gAlphaf[j] = gAlphaf[j] + 180.0 }
    }

    else {
      if (d22Flag && isCW) || (!d22Flag && !isCW) {
        gAlphaf[j] = 180.0 - gAlphaf[j] }

      else {
        gAlphaf[j] = 360.0 - gAlphaf[j] }
    }

    /*  Find arc angles  */
    arcAngle = alphaiT - gAlphaf[j]

    if isCW && arcAngle < 0 {
      arcAngle = arcAngle + 360.0 }

    if !isCW && arcAngle > 0 {
      arcAngle = arcAngle - 360.0 }
  }
}

gArcAngle[j] = arcAngle;
  }    //  End for j


  /*  Find parameters below initialAngleIndex. We need to work backwards  */
  if initialAngleIndex > 15*gCurveNum  /*  If we didn't start at beginning of curve  */
  {
for ( k = initialAngleIndex - 1;  k >= 15*gCurveNum;  k-= )
{
  x1 = gX[k];
  x2 = gX[k + 1];
  y1 = gY[k];
  y2 = gY[k + 1];

  gAlphaf[k] = gAlphai[k + 1];

  alpha12 = gRadToDeg*atan2(y2 - y1, x2 - x1);

  if alpha12 < 0 {
    alpha12 = alpha12 + 360.0 }  /*  To get in range of 0 to 359  */

  dAlpha12 = gAlphaf[k] - alpha12

  if dAlpha12 < 0.0 {
    dAlpha12 = dAlpha12 + 360.0 }  /*  To get in range of 0 to 359  */

  if dAlpha12 == 0.0 {
    gR[k] = 15000.0 }  /*  To get one line  */

  else if dAlpha12 == 180.0 {
    gR[k] = 16000.0 }  /*  To get two lines  */

  else {
    /*  Determine if arc is CW  */
    if dAlpha12 > 180.0 {
      gIsCW[k] = 1
      isCW = 1
    }

    else {
      gIsCW[k] = 0
      isCW = 0
    }

    /*  Find gXc, gYc, and gR  */
    if gAlphaf[k] == 90.0 {
      d12 = 1000000.0 }

    else if gAlphaf[k] == 270.0 {
      d12 = -1000000.0 }

    else {
      d12 = tan(gDegToRad*gAlphaf[k]) }

    /*  We don't need d12Flag or d22Flag because we know alphaf  */

    e = ( -x1*x1 - y1*y1 - x2*x2 + y2*y2 + 2*x1*x2 + 2*d12*y2*(x1 - x2) )
    /( d12*(x2 - x1) + y1 - y2 )

    d = -2*(x2 + d12*y2) - d12*e

    f = -x1*(d + x1) - y1*(e + y1)

    gXc[k] = -d/2
    gYc[k] = -e/2
    gR[k] = sqrt(d*d/4 + e*e/4 - f)
    r1Deg = 57.3*sqrt( (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) )

    if gR[k] > r1Deg) || (gR[k] > 14999.0 {
      gXc[k] = 0.0
      gYc[k] = 0.0

      if fabs(dAlpha12 - 180.0) < 10.0 {
        gR[k] = 16000.0 }  /*  To get two lines  */

      else {
        gR[k] = 15000.0 }  /*  To get one line  */
    }
                          }

                          /*  Find gAlphai[ ]  */

                          if (dAlpha12 == 0.0) || (dAlpha12 == 180.0) {
      gAlphaf[k] = gAlphai[k] }

                          else {
      d11Num = -(2*x1 + d)
      d11Denom = (2*y1 + e)

      if d11Denom == 0 && isCW {
        gAlphai[k] = 90.0 }

      else if d11Denom == 0 && !isCW {
        gAlphai[k] = 270.0 }

      else {
        d11 = d11Num/d11Denom
        if d11 >= 0 {
          d11Flag = true }

        else {
          d11Flag = false }

        d21 = d11*(2*x1 + d) - 2*y1 - e
        if d21 > 0 {
          d21Flag = true }

        else {
          d21Flag = false }

        xRef = 1.0
        yRef = fabs(d11)

        gAlphai[k] = gRadToDeg*atan2(yRef, xRef)  //  In range of 0.0 - 90.0

        if d11Flag {
          if (d21Flag && !isCW) || (!d21Flag && isCW) {
            gAlphai[k] = gAlphai[k] }

          else {
            gAlphai[k] = gAlphai[k] + 180.0 }
        }

        else {
          if (d21Flag && isCW) || (!d21Flag && !isCW) {
            gAlphai[k] = 180.0 - gAlphai[k] }

          else {
            gAlphai[k] = 360.0 - gAlphai[k] }
        }
      }
    }

                          /*  Find start angle  */
                          if isCW {
      startAngle = -gAlphai[k] }

                          else {
      startAngle = 180.0 - gAlphai[k]

      if startAngle < 0.0 {
        startAngle = startAngle + 360.0 }
    }

                          gStartAngle[k] = startAngle

                          /*  Find a truncated alphai for finding arc angle  */
                          if isCW {
      alphaiT = -gStartAngle[k] }
                          else {
      alphaiT = 180.0 - gStartAngle[k]

      if alphaiT < 0.0 {
        alphaiT = alphaiT + 360 }
    }

                          /*  Find arc angle  */
                          arcAngle = alphaiT - gAlphaf[k]

                          if isCW && arcAngle < 0 {
      arcAngle = arcAngle + 360.0 }

                          if !isCW && arcAngle > 0 {
      arcAngle = arcAngle - 360.0 }

                          gArcAngle[k] = arcAngle
                          }    //  End for k
                          }    //  End if

                          /*  We don't change gAppleAngle  */

                          /*     dummy = (gHighCurveNum + gHighDotNum[gCurveNum] + gR[initialAngleIndex])
                           + gAngleFlag[gCurveNum]
                           + (gXc[initialAngleIndex] + gYc[initialAngleIndex] + gStartAngle[gCurveNum])
                           + (gArcAngle[gCurveNum] + gX[initialAngleIndex] + gY[initialAngleIndex])
                           + gAlphai[gCurveNum]
                           + (gCurveNum + gAppleAngle + gX[gCurveNum] + gY[gCurveNum] + x1 + x2 + y1 + y2 + d11 + eNum)
                           + (eDenom + e + d + f + isCW + d12 + d22 + gAlphaf[gCurveNum] + initialAngleIndex)
                           + (highAngleIndex + initialDotIndex + highDotIndex + gAngleIndex[gCurveNum])
                           + (i + j + k) */

                          return;
                          }

            */
