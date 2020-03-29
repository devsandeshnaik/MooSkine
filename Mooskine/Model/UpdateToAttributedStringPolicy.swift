//
//  UpdateToAttributedStringPolicy.swift
//  Mooskine
//
//  Created by Sandesh on 29/03/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

class UpdateToAttributedStringPolicy: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)
        
        guard  let destination = manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [sInstance]).first else {
            return
        }
        
        if let text = sInstance.value(forKey: "text") as? String {
            destination.setValue(NSAttributedString(string: text), forKey: "attributedText")
        }
    }
}
