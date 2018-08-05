//
//  TopEntriesListViewController.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import UIKit
import DomainLayer

class TopEntriesListViewController: UIViewController, TopEntriesListViewInput, UIScrollViewDelegate {
    
    var getTopEntries: GetNextTopEntriesList!
    var output: TopEntriesListViewOutput!
    var adapter: TopEntriesListAdapter!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.onViewDidLoad()
    }
    
    //MARK: - TopEntriesListViewInput
    
    func setupInitialState() {
        self.title = "Reddit"
        
        self.tableView.delegate = self.adapter
        self.tableView.dataSource = self.adapter
        
        self.adapter.tableView = self.tableView
        self.adapter.onBottomReached = { [weak self] in
            guard let `self` = self else { return }
            if !self.isLoading {
                self.output.loadNextBatch()
            }
        }
        self.adapter.onThumbnailTapped = { [weak self] (url) in
            self?.output.onImageTapped(with: url)
        }
        
        self.loader.stopAnimating()
    }
    
    func startLoading() {
        self.isLoading = true
        if self.adapter.isEmpty {
            self.loader.startAnimating()
        }
    }
    
    func stopLoading() {
        self.isLoading = false
        self.loader.stopAnimating()
    }
    
    func clearBatch() {
        self.adapter.clearData()
    }
    
    func batchLoaded(_ items: [EntryViewItem]) {
        self.adapter.appendData(items)
    }
    
}

