//
//  GetTopEntriesList.swift
//  DomainLayer
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

public class GetTopEntriesList: UseCase<GetTopEntriesListArgs, [EntryItem]> {

    private lazy var service = EntriesService()

    public override init() {
    }

    override func build(with args: GetTopEntriesListArgs, onError: (Error) -> Void, onSuccess: ([EntryItem]) -> Void) {
        self.service.build(with: args.limit, offset: args.offset, onError: onError, onSuccess: onSuccess)
    }
}

public struct GetTopEntriesListArgs {
    let offset: Int
    let limit: Int

    public init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
}
