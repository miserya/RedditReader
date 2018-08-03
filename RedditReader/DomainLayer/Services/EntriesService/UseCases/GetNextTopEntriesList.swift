//
//  GetNextTopEntriesList.swift
//  DomainLayer
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

public class GetNextTopEntriesList: UseCase<GetNextTopEntriesListArgs, Pagination<EntryItem>> {

    private lazy var service = EntriesService()

    public override init() {
    }

    override func build(with args: GetNextTopEntriesListArgs,
                        onError: @escaping (Error) -> Void,
                        onSuccess: @escaping (Pagination<EntryItem>) -> Void) {
        self.service.getNextBatch(with: args.limit, offset: args.offset, next: args.next) { (error, entities) in
            if let error = error {
                onError(error)
            }
            else if let entities = entities {
                onSuccess(entities)
            }
            else {
                onError(DomainLayerError.emptyResponse)
            }
        }
    }
}

public struct GetNextTopEntriesListArgs {
    let offset: Int
    let limit: Int
    let next: String?

    public init(offset: Int, limit: Int, next: String? = nil) {
        self.offset = offset
        self.limit = limit
        self.next = next
    }
}
