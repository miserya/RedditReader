//
//  EntryMapper.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import DomainLayer

class EntryMapper {
    
    func transform(_ intput: EntryItem) -> EntryViewItem {
        return EntryViewItem(title: intput.title, authorName: intput.authorName, creationDate: intput.creationDate, thumbnailURL: intput.thumbnailURL, numberOfComments: intput.numberOfComments)
    }
    
    func transform(_ intput: [EntryItem]) -> [EntryViewItem] {
        return intput.map({ [unowned self] (item) -> EntryViewItem in
            return self.transform(item)
        })
    }
    
    func reverseTransform(_ intput: EntryViewItem) -> EntryItem {
        return EntryItem(title: intput.title, authorName: intput.authorName, creationDate: intput.creationDate, thumbnailURL: intput.thumbnailURL, numberOfComments: intput.numberOfComments)
    }
    
    func reverseTransform(_ intput: [EntryViewItem]) -> [EntryItem] {
        return intput.map({ [unowned self] (item) -> EntryItem in
            return self.reverseTransform(item)
        })
    }
}
