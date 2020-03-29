//
//  DataController.swift
//  Mooskine
//
//  Created by Sandesh on 27/03/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistanceContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistanceContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext!
    
    init(modelName: String) {
        persistanceContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContext() {
        backgroundContext = persistanceContainer.newBackgroundContext()
        
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() ->())? = nil) {
        persistanceContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else { fatalError(error!.localizedDescription) }
            self.autoSaveViewContext(interval: 30)
            self.configureContext()
            completion?()
        }
    }
}


extension DataController {
    func autoSaveViewContext(interval:TimeInterval = 30) {
        guard interval > 0 else { print("interval coonot be negitive"); return }
        print("autosaving")
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }
    }
    
}
