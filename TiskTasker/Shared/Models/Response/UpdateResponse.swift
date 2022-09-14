//
//  UpdateTaskResponse.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/6/22.
//

import Foundation

struct UpdateResponse: Decodable {
    var numberOfRecordsUpdated: Int?
}

extension UpdateResponse {
    private enum CodingKeys: String, CodingKey {
        case numberOfRecordsUpdated
    }
}
