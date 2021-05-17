//
//  CheckItem+CoreDataClass.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/17.
//
//

import Foundation
import CoreData

@objc(CheckItem)
public class CheckItem: NSManagedObject {
    
    public class func gemerateRandomItems(contex: NSManagedObjectContext, numberOfItems: Int) {
        (0..<numberOfItems).forEach { index in
            let checkItem = CheckItem(context: contex)
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
    
    public class func createDefaultItem(context: NSManagedObjectContext) -> CheckItem {
        let checkItem = CheckItem(context: context)
        checkItem.name = ""
        checkItem.isChecked = false
        return checkItem
    }
    
    public class func requestwithSorting() -> NSFetchRequest<CheckItem> {
        let request = CheckItem.fetchRequest() as NSFetchRequest<CheckItem>
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CheckItem.name, ascending: true)
        ]
        
        return request
    }

}
