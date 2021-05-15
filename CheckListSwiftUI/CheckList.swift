//
//  CheckList.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/13.
//

import Foundation


struct CheckItem: Identifiable, Codable {
    var name: String = "Item"
    var isChecked: Bool = false
    
    var id: String {
        name
    }
}
