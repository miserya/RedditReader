//
//  EntrieThumbnailPreviewRouter.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 8/5/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import UIKit

class EntrieThumbnailPreviewRouter {
    weak var viewController: UIViewController!

    func showThumbnailPreview() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "EntrieThumbnailPreviewViewController") as! EntrieThumbnailPreviewViewController
        
        let router = EntrieThumbnailPreviewRouter()
        router.viewController = view

        let presenter = EntrieThumbnailPreviewPresenter()
        presenter.stateStorage = EntrieThumbnailPreviewStateStorage()
        presenter.view = view
        presenter.router = router

        view.output = presenter

        self.viewController.navigationController?.pushViewController(view, animated: true)
    }
}
