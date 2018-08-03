//
//  DownloadTask.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

struct DownloadTask {
    let task: URLSessionDownloadTask
    let completion: (Error?, URL?) -> Void
}
