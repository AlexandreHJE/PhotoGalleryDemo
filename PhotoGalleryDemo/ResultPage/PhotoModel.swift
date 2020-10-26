//
//  PhotoModel.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/25.
//

import Foundation

class PhotoModel: NSObject {
    
    var title: String = ""
    var imageURL: String = ""
    var isFavorite: Bool = false
    
    init(title: String, imageURL: String, isFavorite: Bool) {
        self.title = title
        self.imageURL = imageURL
        self.isFavorite = isFavorite
    }
}
