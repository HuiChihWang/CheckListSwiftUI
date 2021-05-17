//
//  EditCheckItemView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/14.
//

import SwiftUI

struct CheckItemDetailView: View {
    @Binding var name: String
    @Binding var isChecked: Bool
    
    var body: some View {
        Form {
            TextField("Enter Item Name", text: $name)
            Toggle("Completed", isOn: $isChecked)
        }
    }
}

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) private var presentationMode
    
    let editItem: CheckItemCore?
    
    var isEditMode: Bool {
        editItem != nil
    }
    
    var navigationTitle: String {
        isEditMode ? "Edit Item" : "New Item"
    }
    
    
    
    @State var name: String
    @State var isChecked: Bool

    init(editItem: CheckItemCore? = nil) {
        self.editItem = editItem

        _name = .init(initialValue: editItem?.name ?? "")
        _isChecked = .init(initialValue: editItem?.isChecked ?? false)
    }
    
    var body: some View {
        CheckItemDetailView(name: $name, isChecked: $isChecked)
        .navigationBarItems(
            trailing: Button("Done") {
                let finishedItem = editItem ?? CheckItemCore(context: context)
                
                finishedItem.name = name
                finishedItem.isChecked = isChecked
                
                self.presentationMode.wrappedValue.dismiss()
            }
            .disabled(name.isEmpty)
        )
        .navigationBarTitle(navigationTitle, displayMode: .inline)
    }
}


struct EditCheckItemView_Previews: PreviewProvider {
    static let container = PersistenceController.previewItems.container
    
    static let item: CheckItemCore = {
        let item = CheckItemCore(context: container.viewContext)
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
