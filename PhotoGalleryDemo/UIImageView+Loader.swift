//
//  UIImageView+Loader.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/26.
//

import UIKit

extension UIImageView {
    
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
      }

      func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
      }
}
