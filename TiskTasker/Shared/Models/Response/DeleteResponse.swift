//
//  DeleteTaskResponse.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/13/22.
//

import Foundation

struct DeleteResponse: Decodable {
    var numberOfRecordsDeleted: Int?
}

extension DeleteResponse {
    private enum CodingKeys: String, CodingKey {
        case numberOfRecordsDeleted
    }
}
