//
//  DataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

protocol DataManager {
    func fetchItemsAsync<T>(for resource: String, as type: [T].Type) async throws -> [T] where T : Decodable
    func getPlistItems(for file: String) -> [[String: AnyObject]]
    func getPlistItem(for file: String) -> [String: AnyObject]
    func getJsonItems<T>(for resource: String, as type: [T].Type, completionHandler: ([T]) -> Void) where T : Decodable
    func getJsonItem<T>(for resource: String, as type: T.Type, completionHandler: (T) -> Void) where T : Decodable
}

extension DataManager {
    func fetchItemsAsync<T>(for resource: String, as type: [T].Type) async throws -> [T] where T : Decodable {
        guard let url = URL(string : resource) else {
            return [T]()
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let items = try JSONDecoder().decode(type, from: data)
        
        return items
    }
    
    func getPlistItems(for file: String) -> [[String: AnyObject]] {
        if let path = Bundle.main.path(forResource: file, ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let items = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: AnyObject]] {
            return items
        }
        
        return []
    }
    
    func getPlistItem(for file: String) -> [String: AnyObject] {
        if let path = Bundle.main.path(forResource: file, ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let item = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: AnyObject] {
            return item
        }
        
        return [:]
    }
    
    func getJsonItems<T>(for resource: String, as type: [T].Type, completionHandler: ([T]) -> Void) where T : Decodable {
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
    
    func getJsonItem<T>(for resource: String, as type: T.Type, completionHandler: (T) -> Void) where T : Decodable {
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
