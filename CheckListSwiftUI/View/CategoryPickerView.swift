//
//  CategoryPickerView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/18.
//

import SwiftUI

struct CategoryPickerView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var catogories: CategoryList
    
    @State private var isCreateCategory = false
    @Binding var selected : ToDoCategory
    
    var body: some View {
        Form {
            Section(header: Text("Category")) {
                ForEach(catogories.categories, id: \.name) { category in
                    HStack {
                        Text(category.name)
                        Spacer()

                        if selected == category {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selected = category
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }

            Section {
                NavigationLink("Add New Category", destination: CategoryCreateView())
                    .foregroundColor(.blue)
            }
        }
        .navigationBarTitle("Choose Category", displayMode: .inline)

    }
}

struct CategoryCreateView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var categories: CategoryList
    
    @State private var categoryName = ""
    
    var body: some View {
        Form {
            TextField("Enter Name Of Category", text: $categoryName)
        }
        .navigationBarTitle("Create New Category")
        .navigationBarItems(
            trailing: Button("Done") {
                let newCategory = ToDoCategory(name: categoryName)
                categories.addCategoy(with: newCategory)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(categoryName.isEmpty)
        )
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList.isPreviewMode = true
        
        return NavigationView {
            CategoryPickerView(selected: .constant(CategoryList.defaultCategory))
                .environmentObject(CategoryList())
        }
    }
}
