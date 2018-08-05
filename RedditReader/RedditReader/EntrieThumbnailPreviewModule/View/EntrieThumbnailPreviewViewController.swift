//
//  EntrieThumbnailPreviewViewController.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 8/5/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import UIKit

class EntrieThumbnailPreviewViewController: UIViewController, EntrieThumbnailPreviewViewInput {

    @IBOutlet weak var imgView: UIImageView!

    var output: EntrieThumbnailPreviewViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.output.onViewDidLoad()
    }

    //MARK: - EntrieThumbnailPreviewViewInput

    func setupInitialState(with imageURL: URL) {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSave))

        self.navigationController?.navigationItem.rightBarButtonItem = rightBarButtonItem

        self.imgView.image = UIImage(data: try! Data(contentsOf: imageURL))
    }

    @objc func onSave() {
        
    }

}
