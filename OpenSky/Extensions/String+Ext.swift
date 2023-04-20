//
//  String+Ext.swift
//  OpenSky
//
//  Created by İlkay Sever on 20.04.2023.
//

import Foundation

extension String {
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
}
