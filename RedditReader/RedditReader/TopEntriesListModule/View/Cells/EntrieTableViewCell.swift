//
//  EntrieTableViewCell.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import UIKit

class EntrieTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelNumberOfComments: UILabel!
    @IBOutlet weak var labelNoImage: UILabel!
    @IBOutlet weak var imgView: ImageView!

    var onImageTapped: ((_ url: URL) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.restoreInitialState()

        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.addTarget(self, action: #selector(onImageViewTapped))
        self.imgView.addGestureRecognizer(tap)
        self.imgView.isUserInteractionEnabled = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.restoreInitialState()
    }

    private func restoreInitialState() {
        self.labelTitle.text = ""
        self.labelAuthor.text = ""
        self.labelTime.text = ""
        self.imgView.image = nil
        self.labelNoImage.isHidden = true
        self.layoutIfNeeded()
    }

    @objc func onImageViewTapped() {
        if let url = self.imgView.localImageURL {
            self.onImageTapped?(url)
        }
    }

}
