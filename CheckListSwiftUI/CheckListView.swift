//
//  CheckListView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/13.
//

import SwiftUI

struct CheckListView: View {
    @ObservedObject private var checklistModel = CheckListViewModel()
    @State private var isShowAddView = false
    @State private var isShowEditView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(checklistModel.items) { item in
                    NavigationLink(
                        destination: EditItemView(checklistModel: checklistModel, editItem: item),
                        label: {
                            CheckItemView(
                                item: item,
                                checkAction: {
                                    checklistModel.checkItem(item: item)
                                },
                                action: {
                                    self.isShowEditView = true
                                }
                            )
                        }
                    )
                }
                .onDelete(perform: checklistModel.remove)
                .onMove(perform: checklistModel.move)
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
                    AddItemView(checklistModel: checklistModel)
                        .onAppear {
                            print("NewChecklistItemView has appeared!")
                        }
                        .onDisappear {
                            print("NewChecklistItemView has disappeared!")
                        }
                }
            )
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) {_ in
            self.checklistModel.saveItems()
        }

    }
}

struct CheckListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckListView()
            .preferredColorScheme(.dark)
    }
}

struct CheckItemView: View {
    let item: CheckItem
    let checkAction: () -> Void
    let action: () -> Void
    
    var body: some View {
        HStack {
            Group {
                Text(item.name)
                Spacer()
            }
            .onTapGesture(perform: action)
            
            Image(systemName: item.isChecked ? "checkmark.circle" : "circle")
                .foregroundColor(.gray)
                .font(.system(size: 20))
                .padding(.trailing, 5)
                .onTapGesture(perform: checkAction)
        }
    }
}
