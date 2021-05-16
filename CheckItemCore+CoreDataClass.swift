//
//  CheckItemCore+CoreDataClass.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/16.
//
//

import Foundation
import CoreData

@objc(CheckItemCore)
public class CheckItemCore: NSManagedObject {
    
    public class func gemerateRandomItems(contex: NSManagedObjectContext, numberOfItems: Int) {
        (0..<numberOfItems).forEach { index in
            let checkItem = CheckItemCore(context: contex)
            checkItem.name = "Item \(index)"
            checkItem.isChecked = [true, false].randomElement()!
            
            do {
                try contex.save()
            }
            catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    public class func createDefaultItem(context: NSManagedObjectContext) -> CheckItemCore {
        let checkItem = CheckItemCore(context: context)
        checkItem.name = ""
        checkItem.isChecked = false
        return checkItem
    }
    
    public class func requestwithSorting() -> NSFetchRequest<CheckItemCore> {
        let request = CheckItemCore.fetchRequest() as NSFetchRequest<CheckItemCore>
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CheckItemCore.name, ascending: true)
        ]
        
        return request
    }
}
