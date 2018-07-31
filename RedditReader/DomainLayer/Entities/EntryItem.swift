//
//  EntryItem.swift
//  DomainLayer
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

public struct EntryItem: Decodable {
    public let title: String
    public let authorName: String
    public let creationDate: Date
    public let thumbnailURL: URL
    public let numberOfComments: Int

    public init(title: String, authorName: String, creationDate: Date, thumbnailURL: URL, numberOfComments: Int) {
        self.title = title
        self.authorName = authorName
        self.creationDate = creationDate
        self.thumbnailURL = thumbnailURL
        self.numberOfComments = numberOfComments
    }
}
