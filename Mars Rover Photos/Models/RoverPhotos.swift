//
//  RoverPhotos.swift
//  Mars Rover Photos
//
//  Created by Bogdan Sevcenco on 21.07.2022.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let roverPhoto = try? newJSONDecoder().decode(RoverPhoto.self, from: jsonData)



// MARK: - RoverPhoto
struct RoverPhoto: Codable {
    let photos: [Photo]
}
