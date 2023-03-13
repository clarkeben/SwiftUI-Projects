//
//  Message+CoreDataProperties.swift
//  Chat AI
//
//  Created by Ben Clarke on 13/03/2023.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: Date?
    @NSManaged public var message: String?
    @NSManaged public var sender: String?
    @NSManaged public var chat: Chat?

}

extension Message : Identifiable {

}
