//
//  CheckItem+CoreDataProperties.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/17.
//
//

import Foundation
import CoreData


extension CheckItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckItem> {
        return NSFetchRequest<CheckItem>(entityName: "CheckItem")
    }

    @NSManaged public var isChecked: Bool
    @NSManaged public var name: String?

}

extension CheckItem : Identifiable {
    
}
