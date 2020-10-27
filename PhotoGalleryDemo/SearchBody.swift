//
//  SearchBody.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/22.
//

import Foundation

struct PhotoSearchResult: Codable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable{
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Codable {
    let farm: Int
    let secret: String
    let id: String
    let server: String
    let title: String
}

extension Photo {
    
    func toPhotoModel() -> PhotoModel {
        let imageURL = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
        return PhotoModel(title: title, imageURL: imageURL, isFavorite: false)
    }
}
