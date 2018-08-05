//
//  EntrieThumbnailPreviewViewOutput.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 8/5/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import UIKit

protocol EntrieThumbnailPreviewViewOutput {

    func onViewDidLoad()

    func onNeedSaveImage(_ image: UIImage)
}
