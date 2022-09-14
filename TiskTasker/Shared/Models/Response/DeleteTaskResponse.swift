//
//  DeleteTaskResponse.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/13/22.
//

import Foundation

struct DeleteTaskResponse: Decodable {
    var numberOfRecordsDeleted: Int?
}

extension DeleteTaskResponse {
    private enum CodingKeys: String, CodingKey {
        case numberOfRecordsDeleted
    }
}
