//
//  TopEntriesListModuleInput.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

struct TopEntriesListInputData {
}

protocol TopEntriesListModuleInput: class {
    func configurate(with inputData: TopEntriesListInputData?, moduleOutput: TopEntriesListModuleOutput?)
}
