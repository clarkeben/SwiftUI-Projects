//
//  Chat+CoreDataProperties.swift
//  Chat AI
//
//  Created by Ben Clarke on 13/03/2023.
//
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var message: NSSet?

}

// MARK: Generated accessors for message
extension Chat {

    @objc(addMessageObject:)
    @NSManaged public func addToMessage(_ value: Message)

    @objc(removeMessageObject:)
    @NSManaged public func removeFromMessage(_ value: Message)

    @objc(addMessage:)
    @NSManaged public func addToMessage(_ values: NSSet)

    @objc(removeMessage:)
    @NSManaged public func removeFromMessage(_ values: NSSet)

}

extension Chat : Identifiable {

}
