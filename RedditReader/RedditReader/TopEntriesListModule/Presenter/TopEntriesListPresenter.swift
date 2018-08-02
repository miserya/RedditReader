//
//  TopEntriesListPresenter.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

class TopEntriesListPresenter: TopEntriesListModuleInput, TopEntriesListViewOutput {
        
    weak var view: TopEntriesListViewInput!
    weak var moduleOutput: TopEntriesListModuleOutput?
    var router: TopEntriesListRouter!
    var stateStorage: TopEntriesListStateStorage!
    
    //MARK: - TopEntriesListViewOutput
    
    func onViewDidLoad() {
        self.view.setupInitialState()
    }
    
    //MARK: - TopEntriesListModuleInput
    
    func configurate(with inputData: TopEntriesListInputData?, moduleOutput: TopEntriesListModuleOutput?) {
        self.moduleOutput = moduleOutput
    }
}
