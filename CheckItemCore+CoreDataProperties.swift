//
//  CheckItemCore+CoreDataProperties.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/16.
//
//

import Foundation
import CoreData


extension CheckItemCore {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckItemCore> {
        return NSFetchRequest<CheckItemCore>(entityName: "CheckItemCore")
    }

    @NSManaged public var isChecked: Bool
    @NSManaged public var name: String?

}

extension CheckItemCore : Identifiable {
    public var id: String {
        name ?? ""
    }
    

}
