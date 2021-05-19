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
    
    public override func awakeFromInsert() {
        self.name = ""
        self.isAlarm = false
        self.isChecked = false
        self.dueDate = Date()
        self.category = CategoryList.defaultCategory.name
    }
    
    public class func gemerateRandomItems(contex: NSManagedObjectContext, numberOfItems: Int) {
        (0..<numberOfItems).forEach { index in
            let checkItem = CheckItem(context: contex)
            checkItem.name = "Item \(index)"
            checkItem.isChecked = [true, false].randomElement()!
            checkItem.isAlarm = [true, false].randomElement()!
            
            let start = Date().timeIntervalSinceNow
            let range = start...(start + 1000000)
            checkItem.dueDate = Date(timeIntervalSinceNow: TimeInterval.random(in: range))
            
            do {
                try contex.save()
            }
            catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    public class func requestwithSortingDate() -> NSFetchRequest<CheckItem> {
        let request = CheckItem.fetchRequest() as NSFetchRequest<CheckItem>
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \CheckItem.dueDate, ascending: true)
        ]
        
        return request
    }
    
    public class func createTestItem(context: NSManagedObjectContext) -> CheckItem {
        let checkItem = CheckItem(context: context)
        checkItem.name = "Test"
        return checkItem
    }
    
    
    func toEditInformation() -> EditInformation {
        return EditInformation(
            name: self.name!,
            isChecked: self.isChecked,
            isAlarmOpen: self.isAlarm,
            dueDate: self.dueDate!,
            category: ToDoCategory(name: self.category!)
        )
    }
    
    func injectEditInfo(with info: EditInformation) {
        self.name = info.name
        self.isChecked = info.isChecked
        self.isAlarm = info.isAlarmOpen
        self.dueDate = info.dueDate
        self.category = info.category.name
    }
}
