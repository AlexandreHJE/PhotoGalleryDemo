//
//  DataManager.swift
//  PhotoGalleryDemo
//
//  Created by Alex Hu on 2020/10/22.
//

import Foundation

@objc
class DataManager: NSObject {
    
    @objc
    static let shared  = DataManager()
    
    private(set) var searchKeyWord = ""
    private(set) var imagePerPage = ""
    
    func setSearchSettings(_ keyword: String, _ perPage: String) {
        searchKeyWord = keyword
        imagePerPage = perPage
    }
    
    func getSearchSettings() -> (String, String) {
        return (searchKeyWord, imagePerPage)
    }
    
}

enum DataError: Error {
    case notFound
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Http(Page) Not Found. code 404."
        }
    }
}

extension DataManager {
    
    func fetchData(text: String,
                      imagePerPage: String,
                      currentPage: Int,
                      _ completion: @escaping (Result<PhotoSearchResult, Error>) -> Void) {
        
        let apiUrlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=995414eeb531a0a98dbd5f4ff8e7017c&text=\(text)&per_page=\(imagePerPage)&page=\(currentPage)&format=json&nojsoncallback=1"
        
        guard let url: URL = URL(string: apiUrlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (jsonData, response, error) in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 404 {
                completion(.failure(DataError.notFound))
                return
            }
            if let jsonData = jsonData {
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(PhotoSearchResult.self, from: jsonData)
                    completion(.success(apiResponse))
                    return
                } catch let parseError {
                    completion(.failure(parseError))
                    return
                }
            } else if let error = error {
                completion(.failure(error))
                return
            }
        }
        task.resume()
    }
    
    func fetchImage(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        
        let session: URLSession = URLSession(configuration: .default)
        return session.dataTask(with: url, completionHandler: completionHandler)
    }
}
