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
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    
    var body: some View {
        HStack {
            Group {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.name ?? "")
                        .font(.system(size: 22, weight: .medium, design: .default))
                    Text(dateFormatter.string(from: item.dueDate ?? Date()))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .onTapGesture(perform: action)
            
            if item.isAlarm {
                Image(systemName: "alarm")
                    .foregroundColor(.blue)
                    .font(.system(size: 20))
                    .padding(.trailing, 5)
            }
            
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
