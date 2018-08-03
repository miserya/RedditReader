//
//  TopEntriesListStateStorage.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

struct TopEntriesListStateStorage {
    let requestLimit: Int = 10
    var next: String?
    var prev: String?
}
