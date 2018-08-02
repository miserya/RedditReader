//
//  EntriesRequestTarget.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

enum EntriesRequestTarget {
    case getNextTopEntriesList(nextBatch: String?, limit: Int, offset: Int)
    case getPrevTopEntriesList(prevBatch: String?, limit: Int, offset: Int)
}

extension EntriesRequestTarget: RequestTarget {
    
    var baseURL: String {
        return ServerConfiguration.baseURL
    }
    
    var route: Route {
        switch self {
        
        case .getNextTopEntriesList, .getPrevTopEntriesList:
            return .get("/top.json")
        }
    }
    
    var params: [String : Any]? {
        switch self {
            
        case .getNextTopEntriesList(let nextBatch, let limit, let offset):
            var parameters: [String: Any] = [
                "limit": limit,
                "count": offset
            ]
            if let next = nextBatch {
                parameters["after"] = next
            }
            return parameters
            
        case .getPrevTopEntriesList(let prevBatch, let limit, let offset):
            var parameters: [String: Any] = [
                "limit": limit,
                "count": offset
            ]
            if let prev = prevBatch {
                parameters["before"] = prev
            }
            return parameters
        }
    }
    
}
