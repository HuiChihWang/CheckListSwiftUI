//
//  CheckListSwiftUIApp.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/13.
//

import SwiftUI

@main
struct CheckListSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CheckListView()
        }
    }
}
