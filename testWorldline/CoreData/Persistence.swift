//
//  Persistence.swift
//  techTest
//
//  Created by Luis Villanueva Rivero on 3/3/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<10 {
            let newItem = LocationData(context: viewContext)
            newItem.id = String(index)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "testWorldline")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save(for items: [Location]) {
        items.forEach { locationData in
            let location = LocationData(context: container.viewContext)
            location.title = locationData.title
            location.id = locationData.id
            location.image = locationData.image?.absoluteString
            location.coordinates = locationData.coordinates

        }
        try? container.viewContext.save()
    }

    func load() -> [LocationData] {
        do {
            let data = try container.viewContext.fetch(LocationData.fetchRequest())
            return data
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }

    func delete(item: Location) {
        var itemsData = load()
        itemsData = itemsData.filter { itemData in
            item.id == itemData.id
        }
        itemsData.forEach { locationData in
            container.viewContext.delete(locationData)
        }
        try? container.viewContext.save()
    }

    func deleteAll() {
        load().forEach { locationData in
            container.viewContext.delete(locationData)
        }
        try? container.viewContext.save()
    }
}
