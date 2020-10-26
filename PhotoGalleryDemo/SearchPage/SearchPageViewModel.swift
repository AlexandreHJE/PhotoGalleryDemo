//
//  SearchPageViewModel.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/22.
//

import Foundation

class SearchPageViewModel: NSObject {
    
    var searchKeyWord: String = ""
    var photosPerPage: String = ""
    
    func initializeViewModel() {
        searchKeyWord = ""
        photosPerPage = ""
    }
    
    func setViewModelContent(_ keyWord: String, _ perPage: String) {
        searchKeyWord = keyWord
        photosPerPage = perPage
        setSearchSettingsOnDataManager(keyWord, keyWord)
    }
    
    private func setSearchSettingsOnDataManager(_ keyWord: String, _ perPage: String) {
        DataManager.shared.setSearchSettings(keyWord, perPage)
    }
    
}
