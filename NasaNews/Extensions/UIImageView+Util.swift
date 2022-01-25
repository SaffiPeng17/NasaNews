//
//  UIImageView+Util.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/25.
//

import UIKit

extension UIImageView {

    func downloadImage(url: String, resizedTo size: CGSize? = nil) {
        NetworkManager.fetch(imageUrl: url) { [weak self] downloadedImage in
            let dImage = downloadedImage?.reSizeImage(toSize: size ?? .zero)
            self?.image = dImage
        }
    }
}
