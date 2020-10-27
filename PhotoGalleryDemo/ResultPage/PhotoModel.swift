//
//  PhotoModel.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/25.
//

import Foundation

final class PhotoModel: NSObject {
    
    var title: String = ""
    var imageURL: String = ""
    var isFavorite: Bool = false
    
    init(title: String, imageURL: String, isFavorite: Bool) {
        self.title = title
        self.imageURL = imageURL
        self.isFavorite = isFavorite
    }
}

extension PhotoModel: Decodable { }

extension PhotoModel: Encodable { }

extension PhotoModel {
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? PhotoModel else {
            return false
        }
        
        return
            title == object.title &&
            imageURL == object.imageURL
    }
}
