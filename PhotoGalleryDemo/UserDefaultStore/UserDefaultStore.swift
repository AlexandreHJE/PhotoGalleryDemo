//
//  UserDefaultStore.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/27.
//

import Foundation

class UserDefaultStore {
    
    init() {
        UserDefaults.standard.register(defaults: [UserDefaults.Keys.photoModels: "[]".data(using: .utf8)!])
    }
}

extension UserDefaultStore: ResultPageViewControllerStore {
    
    func save(photoModel: PhotoModel) {
        if let data = UserDefaults.standard.data(forKey: UserDefaults.Keys.photoModels) {
            do {
                let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
                let newPhotos = photos + [photoModel]
                let newData = try JSONEncoder().encode(newPhotos)
                UserDefaults.standard.set(newData, forKey: UserDefaults.Keys.photoModels)
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        } else {
            do {
                let newData = try JSONEncoder().encode([photoModel])
                UserDefaults.standard.set(newData, forKey: UserDefaults.Keys.photoModels)
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        }
        
        do {
            if let data = UserDefaults.standard.data(forKey: UserDefaults.Keys.photoModels) {
                let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
                photos.forEach({ print($0) })
            }
        } catch {
            print(error)
        }
    }
    
    func delete(photoModel: PhotoModel) {
        if let data = UserDefaults.standard.data(forKey: UserDefaults.Keys.photoModels) {
            do {
                let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
                let newPhotos = photos.filter({ $0 != photoModel })
                let newData = try JSONEncoder().encode(newPhotos)
                UserDefaults.standard.set(newData, forKey: UserDefaults.Keys.photoModels)
                UserDefaults.standard.synchronize()
            } catch {
                //Handle error
            }
        } else {
            //Handle error
            //Should not here
        }
        
        do {
            if let data = UserDefaults.standard.data(forKey: UserDefaults.Keys.photoModels) {
                let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
                photos.forEach({ print($0) })
            }
        } catch {
            //Handle error
        }
    }
}

fileprivate extension UserDefaults.Keys {
    
    static let photoModels = "photoModels"
}

extension UserDefaultStore: FavoritePageViewModelStore {
    
}
