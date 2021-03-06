//
//  CheckListView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/13.
//

import SwiftUI

struct CheckListView: View {
    @Environment(\.managedObjectContext) private var managedContext
    
    @FetchRequest(
        fetchRequest: CheckItem.requestwithSortingDate()
    ) private var items: FetchedResults<CheckItem>
    
    @State private var isShowAddView = false
    @State private var isShowEditView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(
                        destination: EditItemView(editItem: item),
                        label: {
                            CheckItemView(item: item)
                        }
                    )
                }
                .onDelete(perform: deleteItem)
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("CheckList")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button("Add") {
                    self.isShowAddView = true
                }
            )
            .sheet(
                isPresented: $isShowAddView,
                content: {
                    NavigationView {
                        AddItemView()
                    }
                }
            )
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            PersistenceController.saveToContainer(with: managedContext)
        }

    }
    
    private func deleteItem(atOffSet indexes: IndexSet) {
        indexes.forEach { index in
            self.managedContext.delete(items[index])
        }
    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList.isPreviewMode = true
        
        return CheckListView()
            .environment(\.managedObjectContext, PersistenceController.previewItems.container.viewContext)
            .environmentObject(CategoryList())
    }
}


