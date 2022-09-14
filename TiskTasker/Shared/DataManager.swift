//
//  DataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

protocol DataManager {
    func fetchItems<T>(at resource: String, as type: [T].Type) async throws -> [T] where T : Decodable
    func fetchItem<T>(at resource: String, as type: T.Type, using params: [URLQueryItem]) async throws -> T? where T : Decodable
    func addItem<T>(at resource: String, with body: T) async throws -> AddResponse where T : Codable
    func updateItem<T>(at resource: String, with body: T) async throws -> UpdateResponse where T : Codable
    func deleteItem(at resource: String, using params: [URLQueryItem]) async throws -> DeleteResponse
}

extension DataManager {
    func fetchItems<T>(at resource: String, as type: [T].Type) async throws -> [T] where T : Decodable {
        guard let url = URL(string: resource) else {
            return [T]()
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
    func fetchItem<T>(at resource: String, as type: T.Type, using params: [URLQueryItem] = [URLQueryItem]()) async throws -> T? where T : Decodable {
        var urlComponents = URLComponents(string: resource)
        urlComponents?.queryItems = params
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
    func addItem<T>(at resource: String, with body: T) async throws -> AddResponse where T : Codable {
        guard let url = URL(string: resource) else {
            return AddResponse.init(numberOfRecordsInserted: 0)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: jsonBody)
        return try JSONDecoder().decode(AddResponse.self, from: data)
    }
    
    func updateItem<T>(at resource: String, with body: T) async throws -> UpdateResponse where T : Codable {
        guard let url = URL(string: resource) else {
            return UpdateResponse.init(numberOfRecordsUpdated: 0)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: jsonBody)
        return try JSONDecoder().decode(UpdateResponse.self, from: data)
    }
    
    func deleteItem(at resource: String, using params: [URLQueryItem] = [URLQueryItem]()) async throws -> DeleteResponse {
        var urlComponents = URLComponents(string: resource)
        urlComponents?.queryItems = params
        
        guard let url = urlComponents?.url else {
            return DeleteResponse.init(numberOfRecordsDeleted: 0)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(DeleteResponse.self, from: data)
    }
}
