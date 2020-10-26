//
//  ResultPageViewModel.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/25.
//

import Foundation

protocol ResultPageViewModelDelegate: class {
    func viewModel(_ viewModel: ResultPageViewModel, didUpdateAlbumPageData data: [PhotoModel])
    
    func viewModel(_ viewModel: ResultPageViewModel, didUpdateFavorites favorites: [PhotoModel])
    
    func viewModel(_ viewModel: ResultPageViewModel, didReceiveError error: Error)
}

class ResultPageViewModel: NSObject {
    
    var keyword = ""
    var imagePerPage = ""
    var currentPage = 1
    var totalPages = 0
    
    weak var delegate: ResultPageViewModelDelegate?
    
    private(set) var favorites = [PhotoModel]() {
        didSet {
            delegate?.viewModel(self, didUpdateFavorites: favorites)
        }
    }
    
    private(set) var photoTable = [String: PhotoModel]() {
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
    
    private(set) var photoModels = [PhotoModel]() {
        didSet {
            delegate?.viewModel(self, didUpdateAlbumPageData: photoModels)
            print("didset photoModels")
        }
    }
    
    private(set) var connectionError: Error? {
        didSet {
            if let error = connectionError {
                delegate?.viewModel(self, didReceiveError: error)
            }
        }
    }
    
    func getSearchSettings() {
        (keyword, imagePerPage) =  DataManager.shared.getSearchSettings()
    }
    
    func loadContent(keyword: String, imagePerPage: String, currentPage: Int) {
        DataManager.shared.fetchData(text: keyword, imagePerPage: imagePerPage, currentPage: currentPage) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.connectionError = error
                
            case .success(let searchResult):
                self?.totalPages = searchResult.photos.pages
                self?.currentPage = searchResult.photos.page
                
                let arrayOfphotos = searchResult.photos.photo
                let temp = arrayOfphotos.map { $0.toPhotoModel() }
                self?.photoModels.append(contentsOf: temp)
            }
        }
    }
    
    func favoritesUpdates() {
        if let array = UserDefaults.standard.array(forKey: "favoritePhotoID") as? [String] {
            favoritePhotoID = Set(array)
        }
    }
    
}
