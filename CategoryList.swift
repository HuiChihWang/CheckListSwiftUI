//
//  File.swift
//  CheckListSwiftUI
//
//  Created by Hui Chih Wang on 2021/5/19.
//

import Foundation

struct ToDoCategory: Codable, Equatable {
    let name: String
    
    static func == (lhs: ToDoCategory, rhs: ToDoCategory) -> Bool {
        return lhs.name == rhs.name
    }
}

class CategoryList: ObservableObject {
    @Published var categories = [ToDoCategory]() {
        didSet {
            CategoryList.saveCategories(categories: categories)
        }
    }
    
    init() {
        categories = CategoryList.loadCategories()
        
        if categories.isEmpty {
            categories = CategoryList.defaultCategories
        }
    }
    
    public func addCategoy(with category: ToDoCategory) {
        guard !categories.contains(category) else {
            return
        }
        
        categories.append(category)
    }
}

extension CategoryList {
    static let defaultCategory = defaultCategories.first(where: {$0.name == "No Choose"})!
    static var isPreviewMode = false
    
    private static var jsonFilePath: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(isPreviewMode ? "categories_test.json" : "categories.json")
    }
    
    private static var defaultCategories: [ToDoCategory] {
        [
            ToDoCategory(name: "No Choose"),
            ToDoCategory(name: "Work"),
            ToDoCategory(name: "Personal"),
            ToDoCategory(name: "Holiday"),
        ]
    }
    private static func loadCategories() -> [ToDoCategory] {
        var categories = [ToDoCategory]()
        let jsonDecoder = JSONDecoder()
        
        if let data = try? Data(contentsOf: jsonFilePath) {
            do {
                categories = try jsonDecoder.decode([ToDoCategory].self, from: data)
            } catch {
                print("Decode Error: \(error.localizedDescription)")
            }
        }
        
        return categories
    }
    
    private static func saveCategories(categories: [ToDoCategory]) {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(categories)
            try data.write(to: jsonFilePath)
            print("Save category to \(jsonFilePath)")
        } catch {
            print("Save Category Error: \(error.localizedDescription)")
        }
    }
}
