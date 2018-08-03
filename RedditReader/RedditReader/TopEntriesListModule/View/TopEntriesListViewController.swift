//
//  TopEntriesListViewController.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 7/31/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import UIKit
import DomainLayer

class TopEntriesListViewController: UIViewController, TopEntriesListViewInput {
    
    var getTopEntries: GetNextTopEntriesList!
    var output: TopEntriesListViewOutput!
    var adapter: TopEntriesListAdapter!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.onViewDidLoad()
    }
    
    //MARK: - TopEntriesListViewInput
    
    func setupInitialState() {
        self.title = "Reddit"
        
        self.tableView.delegate = self.adapter
        self.tableView.dataSource = self.adapter
        
        self.loader.stopAnimating()
    }
    
    func startLoading() {
        self.loader.startAnimating()
    }
    
    func stopLoading() {
        self.loader.stopAnimating()
    }
    
    func clearBatch() {
        self.adapter.data.removeAll()
        self.tableView.reloadData()
    }
    
    func batchLoaded(_ items: [EntryViewItem]) {
        self.adapter.data.append(contentsOf: items)
        self.tableView.reloadData()
    }
}

