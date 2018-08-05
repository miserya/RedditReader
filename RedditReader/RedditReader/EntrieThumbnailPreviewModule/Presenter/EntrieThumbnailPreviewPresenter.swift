//
//  EntrieThumbnailPreviewPresenter.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 8/5/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import UIKit

class EntrieThumbnailPreviewPresenter: EntrieThumbnailPreviewModuleInput, EntrieThumbnailPreviewViewOutput {

    weak var view: EntrieThumbnailPreviewViewController!
    var router: EntrieThumbnailPreviewRouter!
    var moduleOutput: EntrieThumbnailPreviewModuleOutput?
    var stateStorage: EntrieThumbnailPreviewStateStorage!
    var savingManager: ImageSavingManager!

    //MARK: - EntrieThumbnailPreviewModuleInput

    func configurate(with inputData: EntrieThumbnailPreviewInputData, moduleOutput: EntrieThumbnailPreviewModuleOutput?) {
        self.moduleOutput = moduleOutput
        self.stateStorage.imagURL = inputData.imageURL
    }

    //MARK: - EntrieThumbnailPreviewViewOutput

    func onViewDidLoad() {
        self.view.setupInitialState(with: self.stateStorage.imagURL)
    }

    func onNeedSaveImage(_ image: UIImage) {
        self.savingManager.saveImage(image) { [weak self] (success) in
            guard let `self` = self else { return }
            if success {
                self.view.showSuccessAlert()
            }
            else {
                self.view.showFailAlert()
            }
        }
    }

}
