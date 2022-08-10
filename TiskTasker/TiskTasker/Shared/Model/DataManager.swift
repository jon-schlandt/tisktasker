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
    func loadJsonItems<T>(for resource: String, as type: [T].Type, completionHandler: ([T]) -> Void) where T : Decodable
    func loadJsonItem<T>(for resource: String, as type: T.Type, completionHandler: (T) -> Void) where T : Decodable
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
    
    func loadJsonItems<T>(for resource: String, as type: [T].Type, completionHandler: ([T]) -> Void) where T : Decodable {
        if let url = Bundle.main.url(forResource: resource, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let items = try JSONDecoder().decode(type, from: data)
                
                completionHandler(items)
            } catch {
                print("There was an error: \(error)")
            }
        }
    }
    
    func loadJsonItem<T>(for resource: String, as type: T.Type, completionHandler: (T) -> Void) where T : Decodable {
        if let url = Bundle.main.url(forResource: resource, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let item = try JSONDecoder().decode(type, from: data)
                
                completionHandler(item)
            } catch {
                print("There was an error: \(error)")
            }
        }
    }
}
