//
//  EditCheckItemView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/14.
//

import SwiftUI

enum ItemCategory: String, CaseIterable {
    case none = "No Choose"
    case work
    case holiday
    case personal
}

struct EditInformation {
    var name: String = ""
    var category = ItemCategory.none
    var isChecked: Bool = false
    var isAlarmOpen: Bool = false
    var dueDate = Date()
}

struct CheckItemDetailView: View {
    @Binding var editInfo: EditInformation
    
    var body: some View {
        Form {
            
            Section(header: Text("Basic Information")) {
                TextField("Enter Item Name", text: $editInfo.name)
                Picker("Category", selection: $editInfo.category) {
                    ForEach(ItemCategory.allCases, id: \ItemCategory.rawValue) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                
                Toggle("Check", isOn: $editInfo.isChecked)
            }
            
            Section(header: Text("Reminder")) {
                
                DatePicker("Due Date",
                           selection: $editInfo.dueDate,
                           in: Date()...,
                           displayedComponents: [.date]
                )
                .datePickerStyle(CompactDatePickerStyle())
                
                Toggle("Alarm", isOn: $editInfo.isAlarmOpen)
            }
            
            
        }
    }
}

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) private var presentationMode
    
    var editItem: CheckItem?
    
    var isEditMode: Bool {
        editItem != nil
    }
    
    var navigationTitle: String {
        isEditMode ? "Edit Item" : "New Item"
    }
    
    @State var editInformation: EditInformation
    
    init(editItem: CheckItem? = nil) {
        self.editItem = editItem
        
        _editInformation = .init(initialValue: self.editItem?.toEditInformation() ?? EditInformation())
    }
    
    var body: some View {
        CheckItemDetailView(editInfo: $editInformation)
            .navigationBarItems(
                trailing: Button("Done") {
                    let finishedItem = editItem ?? CheckItem(context: context)
                    finishedItem.injectEditInfo(with: editInformation)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(editInformation.name.isEmpty)
            )
            .navigationBarTitle(navigationTitle, displayMode: .inline)
    }
}


struct EditCheckItemView_Previews: PreviewProvider {
    static let container = PersistenceController.previewItems.container
    
    static let item: CheckItem = {
        let item = CheckItem(context: container.viewContext)
        item.name = "Sex"
        item.isChecked = [true, false].randomElement()!
        return item
    }()
    
    static var previews: some View {
        NavigationView {
            EditItemView()
        }
        .environment(\.managedObjectContext, container.viewContext)
        
    }
}
