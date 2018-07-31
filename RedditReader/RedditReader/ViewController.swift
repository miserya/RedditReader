//
//  ViewController.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import UIKit
import DomainLayer

class ViewController: UIViewController {

    let getTopEntries = GetTopEntriesList()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getTopEntries.execute(with: GetTopEntriesListArgs(offset: 0, limit: 10), onError: { (error) in
            print("ERROR: \(error.localizedDescription)")
        }) { (items) in
            print("items.count = \(items.count)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

