//
//  Contacts+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by JHJG on 2016. 7. 15..
//  Copyright © 2016년 KangJungu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contacts {

    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var phone: String?

}
