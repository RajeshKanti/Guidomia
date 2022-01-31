//
//  CoreData.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-30.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    func saveCarInfosToData(carList: [CarModel]) {
        
        guard let context = context else {
          return
        }
                
        for carObj in carList {
            let entity = NSEntityDescription.entity(forEntityName: "CarEntity", in: context)!
            let car = NSManagedObject(entity: entity, insertInto: context)
            
            car.setValue(carObj.make, forKeyPath: "make")
            car.setValue(carObj.model, forKeyPath: "model")
            car.setValue(carObj.customerPrice, forKeyPath: "customerPrice")
            car.setValue(carObj.marketPrice, forKeyPath: "marketPrice")
            car.setValue(carObj.rating, forKeyPath: "rating")
            car.setValue(carObj.prosList, forKeyPath: "prosList")
            car.setValue(carObj.consList, forKeyPath: "consList")
            
            do {
              try context.save()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchCarInfosFromCoreData() -> [NSManagedObject]? {
        
        var cars: [NSManagedObject] = []
        
        guard let context = context else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarEntity")
        
        do {
            cars = try context.fetch(fetchRequest)
            return cars
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}
