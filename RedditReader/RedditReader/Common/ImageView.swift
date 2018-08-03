//
//  ImageView.swift
//  RedditReader
//
//  Created by Maria Golubeva on 8/3/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import UIKit
import DomainLayer

class ImageView: UIImageView {
    
    private var currentURL: URL?
    
    override var image: UIImage? {
        get {
            return super.image
        }
        set(newValue) {
            super.image = newValue
            self.download.cancel()
        }
    }
    
    private let download: Download = Download()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(frame: self.bounds)
        loader.hidesWhenStopped = true
        loader.startAnimating()
        addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: self.topAnchor),
            loader.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        return loader
    }()
    
    func setImageURL(_ imageURL: URL) {
        self.loader.startAnimating()
        self.currentURL = imageURL
        self.download.execute(with: imageURL, onError: { [weak self] (error) in
            guard let `self` = self else { return }
            self.loader.stopAnimating()
            debugPrint("DOWNLOADING ERROR: \(error.localizedDescription)")
        }) { [weak self] (fileURL) in
            guard let `self` = self else { return }
            self.loader.stopAnimating()
            
            if imageURL == self.currentURL {
                do {
                    let data = try Data(contentsOf: fileURL)
                    self.image = UIImage(data: data)
                    debugPrint("SUCCESS PARSING IMAGE DATA: \(fileURL.absoluteString)")
                }
                catch {
                    debugPrint("PARSING IMAGE DATA ERROR: \(error.localizedDescription) \(fileURL.absoluteString)")
                }
            }
        }
    }
    
}
