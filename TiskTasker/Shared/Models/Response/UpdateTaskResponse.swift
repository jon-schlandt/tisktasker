//
//  UpdateTaskResponse.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/6/22.
//

import Foundation

struct UpdateTaskResponse: Decodable {
    var numberOfRecordsUpdated: Int?
}

extension UpdateTaskResponse {
    private enum CodingKeys: String, CodingKey {
        case numberOfRecordsUpdated
    }
}
