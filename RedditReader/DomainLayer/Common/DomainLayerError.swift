//
//  DomainLayerError.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

public enum DomainLayerError: Error {
    case emptyResponse
    case invalidRequest
}

extension DomainLayerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "Empty response"
        case .invalidRequest:
            return "Invalid request configuration"
        }
    }
}
