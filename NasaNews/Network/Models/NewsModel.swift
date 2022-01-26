//
//  NewsModel.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import Foundation

struct NewsModel: Codable {
    let title: String
    let description: String
    let date: String
    let mediaType: String
    let apodSite: String
    let thumbnailImageURL: String
    let originalImageurl: String
    let copyright: String

    enum CodingKeys: String, CodingKey {
        case title, description, date, mediaType = "media_type", apodSite = "apod_site", thumbnailImageURL = "url", originalImageurl = "hdurl", copyright
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        date = try values.decode(String.self, forKey: .date)
        mediaType = try values.decode(String.self, forKey: .mediaType)
        apodSite = try values.decode(String.self, forKey: .apodSite)
        thumbnailImageURL = try values.decode(String.self, forKey: .thumbnailImageURL)
        originalImageurl = try values.decode(String.self, forKey: .originalImageurl)
        copyright = try values.decode(String.self, forKey: .copyright)
    }
}
