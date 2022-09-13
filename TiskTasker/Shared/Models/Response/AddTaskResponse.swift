//
//  AddTaskResponse.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/12/22.
//

import Foundation

struct AddTaskResponse: Decodable {
    var numberOfRecordsInserted: Int?
}

extension AddTaskResponse {
    private enum CodingKeys: String, CodingKey {
        case numberOfRecordsInserted
    }
}
