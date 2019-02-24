//
//  UIImageView+Extension.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func lazyLoad(url: String, onSuccess: @escaping (UIImage) -> Void) {
        let imageProviderService = ImageProviderService.shared
        imageProviderService.getImage(url: url) { (result) in
            switch result {
            case .success(let image):
                onSuccess(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    func setImageWithFadeAnimation(_ image: UIImage, duration: TimeInterval = 0.2) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in self?.image = image })
    }
}
