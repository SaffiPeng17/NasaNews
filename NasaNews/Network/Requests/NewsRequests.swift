//
//  NewsRequests.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/25.
//

import Foundation

extension NetworkManager {
    class func getNews(urlString: String, completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        return fetch(url: url, completion: completion)
    }
}
