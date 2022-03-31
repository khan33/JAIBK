//
//  UIImageView+.swift
//  JAIBK
//
//  Created by Atta khan on 29/03/2022.
//

import Foundation
import UIKit
import SDWebImage


extension UIImageView {
    func downloadImage(url: URL, placeholder: UIImage, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        self.sd_setImage(with: url, placeholderImage: placeholder, options: .retryFailed)
    }
}
