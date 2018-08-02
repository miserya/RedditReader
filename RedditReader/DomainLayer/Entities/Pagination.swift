//
//  Pagination.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

public struct Pagination<Item: Decodable>: Decodable {
    public let count: Int
    public let next: String?
    public let prev: String?
    public let items: [Item]
    
    private enum CodingKeys: String, CodingKey {
        case data
        case count = "dist"
        case next = "after"
        case prev = "before"
        case items = "children"
    }
    
    public init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        self.items = try container.decode([Item].self, forKey: .items)
        self.count = try container.decode(Int.self, forKey: .count)
        self.next = try? container.decode(String.self, forKey: .next)
        self.prev = try? container.decode(String.self, forKey: .prev)
    }
}
