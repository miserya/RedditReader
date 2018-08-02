//
//  EntriesService.swift
//  DomainLayer
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

class EntriesService {
    
    func getNextBatch(with limit: Int, offset: Int, next: String?, onComplete: @escaping (Error?, Pagination<EntryItem>?) -> Void) {
        NetworkingManager.default.request(EntriesRequestTarget.getNextTopEntriesList(nextBatch: next, limit: limit, offset: offset), completion: onComplete)
    }
}
