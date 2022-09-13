//
//  DataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

protocol DataManager {
    func fetchItems<T>(at resource: String, as type: [T].Type) async throws -> [T] where T : Decodable
    func fetchItem<T>(at resource: String, as type: T.Type) async throws -> T? where T : Decodable
    func addItem<T>(at resource: String, with body: T) async throws -> AddTaskResponse where T : Codable
    func updateItem<T>(at resource: String, with body: T) async throws -> UpdateTaskResponse where T : Codable
}

extension DataManager {
    func fetchItems<T>(at resource: String, as type: [T].Type) async throws -> [T] where T : Decodable {
        guard let url = URL(string: resource) else {
            return [T]()
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
    func fetchItem<T>(at resource: String, as type: T.Type) async throws -> T? where T : Decodable {
        guard let url = URL(string: resource) else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
    func addItem<T>(at resource: String, with body: T) async throws -> AddTaskResponse where T : Codable {
        guard let url = URL(string: resource) else {
            return AddTaskResponse.init(numberOfRecordsInserted: 0)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: jsonBody)
        return try JSONDecoder().decode(AddTaskResponse.self, from: data)
    }
    
    func updateItem<T>(at resource: String, with body: T) async throws -> UpdateTaskResponse where T : Codable {
        guard let url = URL(string: resource) else {
            return UpdateTaskResponse.init(numberOfRecordsUpdated: 0)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: jsonBody)
        return try JSONDecoder().decode(UpdateTaskResponse.self, from: data)
    }
}
