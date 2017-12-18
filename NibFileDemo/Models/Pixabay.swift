//
//  Pixabay.swift
//  NibFileDemo
//
//  Created by C4Q  on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct PixabayResults: Codable {
    var hits: [Pixabay]
}

struct Pixabay: Codable {
    let likes: Int
    let tags: String
    let webformatURL: String
    static let noDataPixabay = Pixabay(likes: 0, tags: "n/a", webformatURL: "n/a")
    /*
    static let testPixabays = [
        Pixabay(likes: 1, tags: "test,one"),
        Pixabay(likes: 2, tags: "test,two"),
        Pixabay(likes: 3, tags: "test,three")
    ]
     */
}

struct PixabayAPIClient {
    private init() {}
    static let manager = PixabayAPIClient()
    static let key = "7279094-3ddaaa4a7753197b307108035"
    func getFirstImage(named str: String, completionHandler: @escaping (Pixabay) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let request = buildRequest(with: str) else {errorHandler(AppError.badURL(str: str)); return}
        let parsePixabay: (Data) -> Void = {(data: Data) in
            do {
                let allResults = try JSONDecoder().decode(PixabayResults.self, from: data)
                let firstPixabay = allResults.hits.first ?? Pixabay.noDataPixabay
                completionHandler(firstPixabay)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parsePixabay, errorHandler: errorHandler)
    }
    
    func getImages(named str: String, completionHandler: @escaping ([Pixabay]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let request = buildRequest(with: str) else {errorHandler(AppError.badURL(str: str)); return}
        let parsePixabays: (Data) -> Void = {(data) in
            do {
                let allResults = try JSONDecoder().decode(PixabayResults.self, from: data)
                let pixabays = allResults.hits
                completionHandler(pixabays)
            }
            catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parsePixabays, errorHandler: errorHandler)
    }
    
    
    private func buildRequest(with str: String) -> URLRequest? {
        let urlStr = "https://pixabay.com/api/?key=\(PixabayAPIClient.key)&q=" + str
        guard let url = URL(string: urlStr) else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}
