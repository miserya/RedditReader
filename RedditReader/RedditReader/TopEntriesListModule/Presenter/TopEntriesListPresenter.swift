//
//  TopEntriesListPresenter.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import DomainLayer

class TopEntriesListPresenter: TopEntriesListModuleInput, TopEntriesListViewOutput {
    
    weak var view: TopEntriesListViewInput!
    weak var moduleOutput: TopEntriesListModuleOutput?
    var router: TopEntriesListRouter!
    var stateStorage: TopEntriesListStateStorage!
    var mapper: EntryMapper!
    
    private let getNextTopEntries = GetNextTopEntriesList()
    
    //MARK: - TopEntriesListViewOutput
    
    func onViewDidLoad() {
        self.view.setupInitialState()
        self.loadNextBatch()
    }
    
    //MARK: - TopEntriesListModuleInput
    
    func configurate(with inputData: TopEntriesListInputData?, moduleOutput: TopEntriesListModuleOutput?) {
        self.moduleOutput = moduleOutput
    }
    
    func loadNextBatch() {
        self.view.startLoading()
        self.getNextTopEntries.execute(with: GetNextTopEntriesListArgs(offset: 0, limit: self.stateStorage.requestLimit, next: self.stateStorage.next), onError: { [weak self] (error) in
            guard let `self` = self else { return }
            debugPrint("ERROR: \(error.localizedDescription)")
            self.view.stopLoading()
        }) { [weak self] (response) in
            guard let `self` = self else { return }
            self.view.stopLoading()
            self.stateStorage.next = response.next
            self.stateStorage.prev = response.prev
            self.view.batchLoaded(self.mapper.transform(response.items))
        }
    }

    func onImageTapped(with imageURL: URL) {
        self.router.showThumbnailPreview(with: imageURL)
    }
}
