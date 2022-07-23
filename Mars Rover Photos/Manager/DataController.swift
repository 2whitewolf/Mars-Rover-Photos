//
//  DataController.swift
//  Mars Rover Photos
//
//  Created by Bogdan Sevcenco on 23.07.2022.
//

import Foundation
import CoreData

final class DataController {

    let container: NSPersistentContainer

    init() {

        container = NSPersistentContainer(name: "Main")

        container.loadPersistentStores(completionHandler: { description, error in

            if let error = error {

                fatalError("Core Data store failed to load with error: \(error)")

            }

        })

    }

    func save() {

        if container.viewContext.hasChanges {

            try? container.viewContext.save()

        }

    }

    func delete(_ rover: Rover) {

        container.viewContext.delete(rover)

    }

}
