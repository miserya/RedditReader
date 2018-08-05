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
    public let thumbnailURL: URL?
    public let numberOfComments: Int

    public init(title: String, authorName: String, creationDate: Date, thumbnailURL: URL?, numberOfComments: Int) {
        self.title = title
        self.authorName = authorName
        self.creationDate = creationDate
        self.thumbnailURL = thumbnailURL
        self.numberOfComments = numberOfComments
    }
    
    private enum CodingKeys: String, CodingKey {
        case data
        case title
        case authorName = "author"
        case creationDate = "created"
        case thumbnailURL = "thumbnail"
        case numberOfComments = "num_comments"
    }
    
    public init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.authorName = try container.decode(String.self, forKey: .authorName)
        self.numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
        
        let urlString = try container.decode(String.self, forKey: .thumbnailURL)
        let url = URL(string: urlString)!
        if (url.scheme == "http" || url.scheme == "https") && url.pathExtension == "jpg" {
            self.thumbnailURL = url
        }
        else {
            self.thumbnailURL = nil
        }
        
        let timeStamp = try container.decode(TimeInterval.self, forKey: .creationDate)
        self.creationDate = Date(timeIntervalSince1970: timeStamp)
    }
}
