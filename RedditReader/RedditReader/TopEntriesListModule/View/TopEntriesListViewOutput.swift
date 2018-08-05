//
//  TopEntriesListViewOutput.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

protocol TopEntriesListViewOutput: class {
    func onViewDidLoad()
    
    func loadNextBatch()

    func onImageTapped(with imageURL: URL)
}
