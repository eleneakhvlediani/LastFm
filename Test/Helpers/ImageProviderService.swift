//
//  ImageProviderService.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class ImageProviderService {
    enum Error: Swift.Error {
        case missingDownloadURL
        case badURL
        case dataCorrupted
        case donwloadFailed
    }
    
    private let imagesCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageProviderService()
    
    func getImage(url: String, completionHandler: @escaping (Result<UIImage>) -> Void ) {
        if let cachedImage = object(forKey: url) {
            completionHandler(.success(cachedImage))
        } else {
            guard let _url = URL(string: url) else {
                completionHandler(.failure(Error.badURL))
                return
            }
            Alamofire.request(_url).responseData { [weak self] (response) in
                switch response.result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completionHandler(.failure(Error.dataCorrupted))
                        return
                    }
                    self?.setObject(image: image, forKey: url)
                completionHandler(.success(image))
                case .failure:
                    completionHandler(.failure(Error.donwloadFailed))
                }
            }
        }
    }
    
    private func object(forKey key: String) -> UIImage? {
        let key = NSString(string: key)
        return imagesCache.object(forKey: key)
    }
    
    private func setObject(image: UIImage, forKey key: String) {
        let key = NSString(string: key)
        imagesCache.setObject(image, forKey: key)
    }
}
