//
//  UIImage+Util.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/25.
//

import Foundation
import UIKit

extension UIImage {

    func reSizeImage(toSize newSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
