//
//  string_ext.swift
//  Orion_Innovation_TestTask
//
//  Created by Даниил Алексеев on 05.06.2021.
//

import Foundation

public extension String {
    func byIndex(_ index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)])
    }
    
    func substring(from: Int, to: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: to)
        let range = start..<end
        return String(self[range])
    }
}
