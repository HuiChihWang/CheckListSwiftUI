//
//  EditCheckItemView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/14.
//

import SwiftUI

struct EditInformation {
    var name: String = ""
    var isChecked: Bool = false
    var isAlarmOpen: Bool = false
    var dueDate = Date()
    var category = CategoryList.defaultCategory
}

struct CheckItemDetailView: View {
    @Binding var editInfo: EditInformation
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                TextField("Enter Item Name", text: $editInfo.name)
                
                NavigationLink(destination: CategoryPickerView(selected: $editInfo.category)) {
                    HStack {
                        Text("Category")
                        Spacer()
                        Text(editInfo.category.name)
                            .foregroundColor(.gray)
                    }
                }
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
    
    let editItem: CheckItem
    @State var editInformation: EditInformation
    
    init(editItem: CheckItem) {
        self.editItem = editItem
        _editInformation = .init(initialValue: self.editItem.toEditInformation())
    }
    
    var body: some View {
        CheckItemDetailView(editInfo: $editInformation)
            .navigationBarTitle("Edit Item", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    editItem.injectEditInfo(with: editInformation)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(editInformation.name.isEmpty)
            )
    }
}


struct AddItemView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var editInformation = EditInformation()

    
    var body: some View {
        CheckItemDetailView(editInfo: $editInformation)
            .navigationBarTitle("Add Item", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    let newItem = CheckItem(context: context)
                    newItem.injectEditInfo(with: editInformation)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(editInformation.name.isEmpty)
            )
    }
}

struct EditCheckItemView_Previews: PreviewProvider {
    static let container = PersistenceController.previewItems.container
    
    static var previews: some View {
        CategoryList.isPreviewMode = true
        
        return NavigationView {
            AddItemView()
        }
        .environment(\.managedObjectContext, container.viewContext)
        .environmentObject(CategoryList())
        
    }
}
