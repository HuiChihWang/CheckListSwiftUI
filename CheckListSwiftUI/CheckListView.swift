//
//  CheckListView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/13.
//

import SwiftUI

struct CheckListView: View {
    @ObservedObject var checklistModel = CheckListViewModel()
    @State var isShowAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(checklistModel.items) { item in
                    CheckItemView(item: item)
                        .onTapGesture {
                            checklistModel.checkItem(item: item)
                        }
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
            .sheet(isPresented: $isShowAddView, content: {
                CheckItemDetailView(checklistModel: checklistModel)
                    .background(Color(UIColor.systemBackground))
            })
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
    
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            
            Image(systemName: item.isChecked ? "checkmark.circle" : "circle")
                .font(.system(size: 20))
                .padding(.trailing, 5)
            
        }
        .contentShape(Rectangle())
    }
}
