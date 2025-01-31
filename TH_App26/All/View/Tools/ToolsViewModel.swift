//
//  ToolsViewModel.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI
import CoreData

final class ToolsViewModel: ObservableObject {
    
    @Published var categories: [String] = ["Hand & Manual Tools", "Power & Electric Tools", "Cutting & Abrasive Tools", "Measuring & Precision Tools", "Specialized & Job-Specific Tools", "Other"]
    @Published var currCat = ""
    
    @Published var conditions: [String] = ["Working", "Needs Repair"]
    @Published var currCond = ""

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false

    @Published var toName: String = ""
    @Published var toCat: String = ""
    @Published var toCond: String = ""

    @Published var tools: [ToolModel] = []
    @Published var selectedTool: ToolModel?

    func addTool() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ToolModel", into: context) as! ToolModel

        loan.toName = toName
        loan.toCat = toCat
        loan.toCond = toCond

        CoreDataStack.shared.saveContext()
    }

    func fetchTools() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ToolModel>(entityName: "ToolModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.tools = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.tools = []
        }
    }

}
