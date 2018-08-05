//
//  EntrieThumbnailPreviewPresenter.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 8/5/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

class EntrieThumbnailPreviewPresenter: EntrieThumbnailPreviewModuleInput, EntrieThumbnailPreviewViewOutput {

    weak var view: EntrieThumbnailPreviewViewController!
    var router: EntrieThumbnailPreviewRouter!
    var moduleOutput: EntrieThumbnailPreviewModuleOutput?
    var stateStorage: EntrieThumbnailPreviewStateStorage!

    //MARK: - EntrieThumbnailPreviewModuleInput

    func configurate(with inputData: EntrieThumbnailPreviewInputData, moduleOutput: EntrieThumbnailPreviewModuleOutput?) {
        self.moduleOutput = moduleOutput
        self.stateStorage.imagURL = inputData.imageURL
    }

    //MARK: - EntrieThumbnailPreviewViewOutput

    func onViewDidLoad() {
        self.view.setupInitialState(with: self.stateStorage.imagURL)
    }
}
