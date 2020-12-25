//
//  Strings.swift
//  HMM
//
//  Created by Abdullah on 09/05/1442 AH.
//

import UIKit

extension String {
   func replace(string:String, replacement:String) -> String {
       return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
   }

   func removeWhitespace() -> String {
       return self.replace(string: " ", replacement: "")
   }
 }

