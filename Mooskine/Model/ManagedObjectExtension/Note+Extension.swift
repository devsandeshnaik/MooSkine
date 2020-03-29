//
//  Note+Extension.swift
//  Mooskine
//
//  Created by Sandesh on 29/03/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

extension Note {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
