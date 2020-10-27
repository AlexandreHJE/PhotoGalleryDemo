//
//  FavoritePageViewModel.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/26.
//

import Foundation

import Foundation

protocol FavoritePageViewModelStore {
    func delete(photoModel: PhotoModel)
}

protocol FavoritePageViewModelDelegate: class {
    func viewModel(_ viewModel: FavoritePageViewModel, didUpdateFavorites: [PhotoModel])
}

class FavoritePageViewModel: NSObject {
    
    weak var delegate: FavoritePageViewModelDelegate?
    
    private(set) var favorites = [PhotoModel]() {
        didSet {
            delegate?.viewModel(self, didUpdateFavorites: favorites)
        }
    }
    
    private(set) var photoTable = [String: PhotoModel]() {
        didSet {
            
        }
    }
    
    private(set) var favoritePhotoID = Set<String>() {
        didSet {
            favorites = photoTable
                .filter { (dictionary) -> Bool in
                    return favoritePhotoID.contains(dictionary.key)
                }
                .map({ (dictionary) -> PhotoModel in
                    return dictionary.value
                })
        }
    }
    
    override init() {
        if let array = UserDefaults.standard.array(forKey: "favoritePhotoID") as? [String] {
            favoritePhotoID = Set(array)
        }
    }
    
    
}
