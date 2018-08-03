//
//  DownloadingService.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

class DownloadingService {
    
    func download(from url: URL, completion: @escaping (_ error: Error?, _ fileURL: URL?) -> Void) {
        NetworkingManager.default.requestDownload(with: url, completion: completion)
    }
    
    func cancelTask(with url: URL) {
    }
}
