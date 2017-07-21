//
//  Note.swift
//  Notes
//
//  Created by Joe Lucero on 7/21/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import Foundation

struct Note: Equatable {
    fileprivate static let textKey = "textKey"
    
    var text: String
    var dictionaryRepresentation: [String : String] {
        return [Note.textKey : text]
    }
    
    func containsText(text: String) -> Bool {
        return self.text.contains(text)
    }
    
    // MARK: - Equatable Protocol
    static func ==(lhs: Note, rhs: Note) -> Bool {
        if lhs.text == rhs.text {
            return true
        } else {
            return false
        }
    }
}

extension Note {
    init?(dictionary: [String: String]) {
        guard let text = dictionary[Note.textKey] else {
            return nil
        }
        
        self.init(text: text)
    }
}

