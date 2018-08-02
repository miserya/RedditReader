//
//  TopEntriesListViewController.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import UIKit
import DomainLayer

class TopEntriesListViewController: UIViewController {
    
    var getTopEntries: GetNextTopEntriesList!
    var output: TopEntriesListViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.getTopEntries.execute(with: GetNextTopEntriesListArgs(offset: 0, limit: 10), onError: { (error) in
//            print("ERROR: \(error.localizedDescription)")
//        }) { (items) in
//            print("SUCCESS: items.count = \(items.count)")
//        }
    }

}

