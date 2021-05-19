//
//  CheckListSwiftUIApp.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/13.
//

import SwiftUI

@main
struct CheckListSwiftUIApp: App {
    private let persistenceController = PersistenceController.shared
    private let categoriesList = CategoryList()
    
    var body: some Scene {
        WindowGroup {
            CheckListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(categoriesList)
        }
    }
}
