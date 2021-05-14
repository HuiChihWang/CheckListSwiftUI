//
//  EditCheckItemView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/14.
//

import SwiftUI

struct CheckItemDetailView: View {
    @Binding var item: CheckItem
    
    var body: some View {
        Form {
            TextField("Enter Item Name", text: $item.name)
            Toggle("Completed", isOn: $item.isChecked)
        }
    }
}

struct AddItemView: View {
    let checklistModel: CheckListViewModel
    
    @State private var newItem = CheckItem(name: "")
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            CheckItemDetailView(item: $newItem)
                .navigationBarTitle("Add Item", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button("Done") {
                        self.checklistModel.addNewItem(item: newItem)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(newItem.name.isEmpty)
            )
        }
    }
}

struct EditItemView: View {
    let checklistModel: CheckListViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State var editItem: CheckItem
    
    var body: some View {
        CheckItemDetailView(item: $editItem)
            .navigationBarTitle("Edit Item", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    self.checklistModel.updateItem(item: editItem)
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
            .disabled(editItem.name.isEmpty)
    }
}


struct EditCheckItemView_Previews: PreviewProvider {
    static var previews: some View {
        CheckItemDetailView(item: .constant(CheckItem()))
    }
}
