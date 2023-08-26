/**

 PictureDefinition

 This class is used to manage the user inputs needed to create an ArcDraw project.

 Overview

 The PictureDefinition class provides a simple structure to manage
 the definition of one instance of a drawing.
 It conforms to the Codable and Identifiable protocols, allowing it to be easily encoded and decoded.
 The information it holds can be stored as a JSON file for reuse and sharing.

 Usage

 To use the PictureDefinition class, simply create an instance of it, providing values for its
 properties as desired. You can then encode and decode instances of the PictureDefinition class
 using the Encoder and Decoder classes, and you can an instance of the PictureDefinition class
 in each document-driven window.

 Note: This class is only available on macOS 12 and higher.
 */

import Foundation
import SwiftUI

 // The user input information defining an ArcDraw picture.
@available(macOS 12.0, *)
struct PictureDefinition: Codable, Identifiable, Equatable {

  var id = UUID()

  var imageWidth: Int =  1100
  var imageHeight: Int = 1000


  init(){
    
  }

  init(

    imageWidth: Int,
    imageHeight: Int

  ) {

    self.imageWidth = imageWidth
    self.imageHeight = imageHeight
  }



  static func ==(lhs: PictureDefinition, rhs: PictureDefinition) -> Bool {
    // Compare all properties here
    return
    lhs.imageWidth == rhs.imageWidth &&
    lhs.imageHeight == rhs.imageHeight
  }

}
