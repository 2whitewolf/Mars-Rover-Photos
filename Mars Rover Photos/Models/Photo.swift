//
//  Photo.swift
//  Mars Rover Photos
//
//  Created by Bogdan Sevcenco on 21.07.2022.
//

import Foundation
// MARK: - Photo
struct Photo: Codable {
    let id: Int
    let imgSrc: String
    let earthDate: String


    enum CodingKeys: String, CodingKey {
        case id
        case imgSrc = "img_src"
        case earthDate = "earth_date"
    }
}
