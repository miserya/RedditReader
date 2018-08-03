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
    @IBOutlet weak var imgView: ImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.restoreInitialState()
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
    }
}
