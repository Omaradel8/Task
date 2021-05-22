//
//  CoreDataManager.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 22/05/2021.
//

import CoreData

final class CoreDataManager {
    
    static let instance = CoreDataManager()
    private init(){}
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "RecipesModel")
        persistentContainer.loadPersistentStores { (_, error) in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    @available(iOS 10.0, *)
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    
    // iOS 9 and below
    lazy var applicationDocumentsDirectory: URL = {

        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "RecipesModel", withExtension: "xcdatamodeld")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("RecipesModel.xcdatamodeld")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            print(error.localizedDescription)
        }
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    var maxCapacity = 10
    
    func saveNewItem(title: String) {
        
        if #available(iOS 10.0, *) {
            let newHistory = RecipeHistory(context: moc)
            newHistory.setValue(title, forKey: "title")
            
            do {
                try  moc.save()
                checkOnMaxCapacity()
            }catch {
                print(error)
            }
        }else{
            let newHistory = RecipeHistory()
            newHistory.setValue(title, forKey: "title")
            
            do {
                try  managedObjectContext.save()
                checkOnMaxCapacity()
            }catch {
                print(error)
            }
        }
    }
    
    func fetchHistory() -> [RecipeHistory] {
        if #available(iOS 10.0, *) {
            do {
                let fetchRequest = NSFetchRequest<RecipeHistory>(entityName: "RecipeHistory")
                let history = try moc.fetch(fetchRequest)
                return history.reversed()
            }catch {
                print(error)
                return []
            }
        }else{
            do {
                let fetchRequest = NSFetchRequest<RecipeHistory>(entityName: "RecipeHistory")
                let history = try managedObjectContext.fetch(fetchRequest)
                return history.reversed()
            }catch {
                print(error)
                return []
            }
        }
    }
    
    func checkOnMaxCapacity() {
        let data = fetchHistory()
        if data.count > maxCapacity {
            deleteLastHistory(object: data.last!)
        }
    }
    
    func deleteLastHistory(object: RecipeHistory){
        
        if #available(iOS 10.0, *) {
            moc.delete(object)
            
            do {
                try moc.save()
            }catch {
                print(error)
            }
        }else{
            managedObjectContext.delete(object)
            
            do {
                try managedObjectContext.save()
            }catch {
                print(error)
            }
        }
    }
}
