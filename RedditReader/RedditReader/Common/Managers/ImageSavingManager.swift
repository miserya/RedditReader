//
//  ImageSavingManager.swift
//  RedditReader
//
//  Created by Mariya Golubeva on 8/5/18.
//  Copyright © 2018 Maria Holubieva. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ImageSavingManager {

    func requestAuthorisation(with completion: ((Bool) -> Void)?) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()

        switch authorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                if status == .authorized {
                    completion?(true)
                } else {
                    completion?(false)
                }
            })

        case .restricted, .denied:
            completion?(false)

        case .authorized:
            completion?(true)
        }
    }

    func saveImage(_ image: UIImage, completion: ((Bool) -> Void)?) {
        self.requestAuthorisation { (success) in
            if success {
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    completion?(true)
                }
            }
            else {
                completion?(false)
            }
        }
    }

}
