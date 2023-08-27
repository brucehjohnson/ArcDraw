

/***************************************************************
 RoundToInt
 **************************************************************

 Round Double number to integer.

 Receives: Double number
 Changes: number into best integer approximation
 Returns: integer number
 */
/*    int  RoundToInt(Double  number)
 {
 var        intNumber: Int    /*   resulting integer   */
 var    absNumber: Double
 var        ceilNumber: Int    /*   ceil() returns a double; we convert to int   */
 var    delta: Double

 absNumber    = fabs( number )
 ceilNumber  = ceil( absNumber )
 delta        = ceilNumber - absNumber

 if delta < 0.5 {
 intNumber = ceilNumber }

 if delta > 0.5 {
 intNumber = ceilNumber - 1.0 }

 if delta == 0.5
 {
 if ( ceilNumber - 1 )%2 > 0 {  //  % means modulus
 intNumber = ceilNumber }
 else {
 intNumber =  ceilNumber - 1 }
 }

 if number < 0 {
 intNumber = -intNumber }

 return  intNumber
 } */
