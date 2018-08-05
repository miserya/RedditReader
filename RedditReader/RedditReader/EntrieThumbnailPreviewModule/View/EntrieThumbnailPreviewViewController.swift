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
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        self.imgView.image = UIImage(data: try! Data(contentsOf: imageURL))
    }

    @objc func onSave() {
        if let image = self.imgView.image {
            self.output.onNeedSaveImage(image)
        }
    }

    func showSuccessAlert() {
        let alert = UIAlertController(title: "Your photo has been saved.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showFailAlert() {
        let alert = UIAlertController(title: "Error", message: "Your photo is not saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
