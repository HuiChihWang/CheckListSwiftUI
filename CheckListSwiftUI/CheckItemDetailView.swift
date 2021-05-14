//
//  EditCheckItemView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/14.
//

import SwiftUI

struct CheckItemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var itemName = ""
    @State var isChecked = false
    
    let checklistModel: CheckListViewModel
    
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Item Name", text: $itemName)
                Toggle("Completed", isOn: $isChecked)
                
            }
            .navigationBarTitle("Create New Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                // new item
                let newItem = CheckItem(name: itemName, isChecked: isChecked)
                checklistModel.addNewItem(item: newItem)
                self.presentationMode.wrappedValue.dismiss()
            }
            .disabled(itemName.isEmpty)
            )
        }
    }
}


struct EditCheckItemView_Previews: PreviewProvider {
    static var previews: some View {
        CheckItemDetailView(checklistModel: CheckListViewModel())
    }
}
