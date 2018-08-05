//
//  EntrieThumbnailPreviewModuleInput.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 8/5/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

struct EntrieThumbnailPreviewInputData {
    let imageURL: URL
}

protocol EntrieThumbnailPreviewModuleInput {
    func configurate(with inputData: EntrieThumbnailPreviewInputData, moduleOutput: EntrieThumbnailPreviewModuleOutput?)
}
