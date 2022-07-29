//
//  DataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

protocol DataManager {
    func loadPlistItems(for file: String) -> [[String: AnyObject]]
    func loadPlistItem(for file: String) -> [String: AnyObject]
}

extension DataManager {
    func loadPlistItems(for file: String) -> [[String: AnyObject]] {
        if let path = Bundle.main.path(forResource: file, ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let items = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: AnyObject]] {
            return items
        }
        
        return []
    }
    
    func loadPlistItem(for file: String) -> [String: AnyObject] {
        if let path = Bundle.main.path(forResource: file, ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let item = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: AnyObject] {
            return item
        }
        
        return [:]
    }
}
