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

// MARK: - Photo
//struct Photo: Codable {
//    let id, sol: Int
//    let camera: Camera
//    let imgSrc: String
//    let earthDate: String
//    let rover: Rover
//
//    enum CodingKeys: String, CodingKey {
//        case id, sol, camera
//        case imgSrc = "img_src"
//        case earthDate = "earth_date"
//        case rover
//    }
//}
struct Photo: Codable {
    let id: Int
//    let camera: Camera
    let imgSrc: String
    let earthDate: String
//    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id
        case imgSrc = "img_src"
        case earthDate = "earth_date"
//        case rover
    }
}

// MARK: - Camera
struct Camera: Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

// MARK: - Rover
struct Rover: Codable {
    let id: Int
    let name, landingDate, launchDate, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
