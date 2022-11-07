//
//  HomeModel.swift
//  din-e-islam
//
//  Created by Ajharudeen Khan on 05/10/22.
//

import UIKit

struct HomeModel: Codable {
    let title : String?
    let desc : String?
    let imageName : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case desc = "description"
        case imageName = "image_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        imageName = try values.decodeIfPresent(String.self, forKey: .imageName)
    }
}
