//
//  TopEntriesListRouter.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/2/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import UIKit

class TopEntriesListRouter {
    weak var viewController: UIViewController!

    func showThumbnailPreview(with imageURL: URL) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "EntrieThumbnailPreviewViewController") as! EntrieThumbnailPreviewViewController

        let router = EntrieThumbnailPreviewRouter()
        router.viewController = view

        let presenter = EntrieThumbnailPreviewPresenter()
        presenter.stateStorage = EntrieThumbnailPreviewStateStorage()
        presenter.view = view
        presenter.router = router
        presenter.savingManager = ImageSavingManager()
        presenter.configurate(with: EntrieThumbnailPreviewInputData(imageURL: imageURL), moduleOutput: nil)

        view.output = presenter

        self.viewController.navigationController?.pushViewController(view, animated: true)
    }
    
}
