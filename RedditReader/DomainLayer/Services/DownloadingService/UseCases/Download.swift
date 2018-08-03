//
//  Download.swift
//  DomainLayer
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation

public class Download: UseCase<URL, URL> {
    
    private lazy var service = DownloadingService()
    
    private var args: URL?
    
    public override init() {
    }
    
    override func build(with args: URL, onError: @escaping (Error) -> Void, onSuccess: @escaping (URL) -> Void) {
        self.args = args
        self.service.download(from: args) { (error, fileURL) in
            if let error = error {
                onError(error)
            }
            else if let fileURL = fileURL {
                onSuccess(fileURL)
            }
            else {
                onError(DomainLayerError.emptyResponse)
            }

        }
    }
    
    public func cancel() {
        if let args = self.args {
            DispatchQueue.global(qos: .userInitiated).async {
                self.service.cancelTask(with: args)
            }
        }
    }
}
