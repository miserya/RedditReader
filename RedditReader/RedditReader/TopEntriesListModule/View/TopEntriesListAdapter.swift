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

    weak var tableView: UITableView?
    
    var isEmpty: Bool {
        return self.data.isEmpty
    }
    
    var onBottomReached: (() -> Void)?
    var onThumbnailTapped: (() -> Void)?
    
    private var data = [EntryViewItem]()
    
    func appendData(_ data: [EntryViewItem]) {
        self.data.append(contentsOf: data)
        self.tableView?.reloadData()
//        if let tableView = self.tableView {
//            let contentOffset = tableView.contentOffset
//            UIView.setAnimationsEnabled(false)
//            tableView.beginUpdates()
//            self.tableView?.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
//            tableView.endUpdates()
//            UIView.setAnimationsEnabled(true)
//            tableView.setContentOffset(contentOffset, animated: false)
//        }
    }
    
    func clearData() {
        self.data.removeAll()
        self.tableView?.reloadData()
    }
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    
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
        cell.imgView.setImageURL(item.thumbnailURL)
        return cell
    }
    
    //MARK: - UIScrollViewDelegate
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if distance < 250 {
            self.onBottomReached?()
        }
    }
    
}
