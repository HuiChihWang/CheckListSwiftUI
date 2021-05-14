//
//  CheckListViewModel.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/14.
//

import Foundation

func generateItems(itemNum: Int) -> [CheckItem] {
    (0..<20).map({ CheckItem(name: "Item \($0)") })
}


class CheckListViewModel: ObservableObject {
    @Published private(set) var items = generateItems(itemNum: 15)
    
    public func addNewItem(item: CheckItem) {
        guard !items.contains(where: { $0.id == item.id }) else {
            return
        }
        
        items.append(item)
    }
    
    public func remove(atOffsets indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    public func move(fromOffsets indices: IndexSet, toOffset newOffSet: Int) {
        items.move(fromOffsets: indices, toOffset: newOffSet)
    }
    
    public func checkItem(item: CheckItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isChecked.toggle()
        }
    }
    
}
