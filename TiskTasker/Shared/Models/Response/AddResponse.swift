//
//  AddTaskResponse.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/12/22.
//

import Foundation

struct AddResponse: Decodable {
    var numberOfRecordsCreated: Int?
}

extension AddResponse {
    private enum CodingKeys: String, CodingKey {
        case numberOfRecordsCreated
    }
}
