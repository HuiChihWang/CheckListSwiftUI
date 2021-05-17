//
//  CheckItemView.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/16.
//

import SwiftUI

struct CheckItemView: View {
    @ObservedObject var item: CheckItem
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            Group {
                Text(item.name ?? "")
                Spacer()
            }
            .onTapGesture(perform: action)
            
            Image(systemName: item.isChecked ? "checkmark.circle" : "circle")
                .foregroundColor(.gray)
                .font(.system(size: 20))
                .padding(.trailing, 5)
                .onTapGesture {
                    item.isChecked.toggle()
                    print("toggle item")
                }
        }
    }
}

struct CheckItemView_Previews: PreviewProvider {
    static let container = PersistenceController.previewItems.container
    
    static let item: CheckItem = {
        let item = CheckItem(context: container.viewContext)
        item.name = "Sex"
        item.isChecked = [true, false].randomElement()!
        return item
    }()
    
    static var previews: some View {
        CheckItemView(item: item)
            .previewLayout(.sizeThatFits)
    }
}
