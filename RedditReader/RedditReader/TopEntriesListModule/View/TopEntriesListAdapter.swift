//
//  TopEntriesListAdapter.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import UIKit

class TopEntriesListAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UITableViewDelegate
    
    //MARK: - UITableViewDataSource
    
    var data = [EntryViewItem]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntrieTableViewCell", for: indexPath) as! EntrieTableViewCell
        cell.labelTitle.text = item.title
        cell.labelAuthor.text = "by \(item.authorName)"
        cell.labelTime.text = item.creationDate.timeAgoString()
        cell.labelNumberOfComments.text = "\(item.numberOfComments.shortStringValue()) Comments"
        return cell
    }
    
}
