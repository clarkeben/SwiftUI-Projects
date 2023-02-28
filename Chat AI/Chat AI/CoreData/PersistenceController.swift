//
//  PersistenceController.swift
//  Chat AI
//
//  Created by Ben Clarke on 25/02/2023.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    static let shared = PersistenceController()
    
    /// Convenience
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Test Configuration
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        return controller
    }()
    
    
    // Init CoreData to use in memory storage
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MessageDataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
                
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // Save CoreData
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}

