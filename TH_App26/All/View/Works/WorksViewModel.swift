//
//  WorksViewModel.swift
//  TH_App26
//
//  Created by IGOR on 31/01/2025.
//

import SwiftUI
import CoreData

final class WorksViewModel: ObservableObject {

    @Published var conditions: [String] = ["Planned", "In progress", "Completed"]
    @Published var currCond = ""

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false

    @Published var woName: String = ""
    @Published var woDate: Date = Date()
    @Published var woM: String = ""
    @Published var woH: String = ""
    @Published var woTool: String = ""
    @Published var woEar: String = ""
    @Published var woCond: String = ""
    @Published var woNewCond: String = ""

    @Published var works: [WorkModel] = []
    @Published var selectedWork: WorkModel?

    func addWork() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "WorkModel", into: context) as! WorkModel

        loan.woName = woName
        loan.woDate = woDate
        loan.woM = woM
        loan.woH = woH
        loan.woTool = woTool
        loan.woEar = woEar
        loan.woCond = woCond
        loan.woNewCond = woNewCond

        CoreDataStack.shared.saveContext()
    }

    func fetchWorks() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<WorkModel>(entityName: "WorkModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.works = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.works = []
        }
    }

}
