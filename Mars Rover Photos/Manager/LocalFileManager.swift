//
//  LocalFileManager.swift
//  Mars Rover Photos
//
//  Created by Sevcenco Bogdan on 22.07.2022.
//
//
//import Foundation
//import UIKit
//
//class LocalFileManager {
//    static let shared = LocalFileManager()
//    let folderName = ""
//    
//    init() {
//        createFolderIfNeeded()
//    }
//    
//    func createFolderIfNeeded() {
//        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
//                .appendingPathComponent(folderName)
//                .path else { return }
//        if !FileManager.default.fileExists(atPath: path) {
//            do {
//                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//                print("Success creating folder.")
//            } catch {
//                print("Error creating folder \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func deleteFolder() {
//        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
//                .appendingPathComponent(folderName)
//                .path else { return }
//        do {
//            try FileManager.default.removeItem(atPath: path)
//            print("Success deleting folder")
//        } catch {
//            print("Error deleting folder \(error.localizedDescription)")
//        }
//    }
//    
//    func saveImage(image: UIImage, name: String) -> String {
//        // Here can be something else in jpegData
////        guard let data = image.pngData(),
//        guard let data = image.jpegData(compressionQuality: 0.5),
//        let path = getPathForImage(name: name) else {
//            return "Error getting data"
//        }
//        
//        do {
//            try data.write(to: path)
//            print(path)
//            return "Success saving!"
//        } catch {
//            return "Error with saving \(error.localizedDescription)"
//        }
//    }
//    
//    func getImage(name: String) -> UIImage? {
//        guard let path = getPathForImage(name: name)?.path,
//              FileManager.default.fileExists(atPath: path) else {
//                  print("Error getting path.")
//                  return nil
//              }
//            return UIImage(contentsOfFile: path)
//    }
//    
//    func deleteImage(name: String) -> String {
//        guard let path = getPathForImage(name: name),
//              FileManager.default.fileExists(atPath: path.path) else {
//                  return "Error getting path."
//              }
//        do {
//            try FileManager.default.removeItem(at: path)
//            return "Sucessfully deleted."
//        } catch {
//            return "Error deleting image. \(error.localizedDescription)"
//        }
//    }
//    
//    func getPathForImage(name: String) -> URL? {
//        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
//                .appendingPathComponent(folderName)
//                .appendingPathComponent("\(name).jpg") else {
//                    print("Error getting path")
//                    return nil
//                }
//        return path
//    }
//    
//}
