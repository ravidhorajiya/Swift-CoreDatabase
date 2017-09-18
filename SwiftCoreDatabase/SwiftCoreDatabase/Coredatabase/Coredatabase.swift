//
//  Coredatabase.swift
//  SwiftCoreDatabase
//
//  Created by Ravi Dhorajiya on 18/09/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

import UIKit
import CoreData

class Coredatabase: NSObject {
    
    //MARK: - Fetch CoreDatabase
    func fetchData(entityName:NSString, prediction:NSString) -> NSArray {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entityDesc:NSEntityDescription = NSEntityDescription.entity(forEntityName: entityName as String, in: context)!
        
        let request:NSFetchRequest<NSFetchRequestResult>
        request = NSFetchRequest.init(entityName: entityName as String)
        request.entity = entityDesc
        request.returnsObjectsAsFaults = false
        
        if prediction .isEqual(to: "") {
        }
        else {
            var predicate:NSPredicate = NSPredicate.init()
            predicate = NSPredicate.init(format: "uid == %@", prediction)
            request.predicate = predicate
        }
        
        do {
            let results = try context.fetch(request)
            if results.count == 0 {
                return []
            }
            else {
                return results as NSArray
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    //MARK: - Insert/Update In CoreDatabase
    func InsertAndUpdateData(entityData:NSMutableArray, entityName:NSString, prediction:NSString) -> Bool {
        var insertSuccess = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let FetchReq:NSFetchRequest<NSFetchRequestResult>
        FetchReq = NSFetchRequest.init(entityName: entityName as String)
        FetchReq.entity = NSEntityDescription.entity(forEntityName: entityName as String, in: context)
        let predicate = NSPredicate.init(format: "uid == %@", prediction)
        FetchReq.predicate = predicate
        
        do {
            let results = try context.fetch(FetchReq)
            
            if results.count == 0 {
                let insertData:NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: entityName as String, into: context)
                
                for i:NSInteger in 0 ..< entityData.count {
                    let objectRecord:NSDictionary = entityData.object(at: i) as! NSDictionary
                    for key in objectRecord.allKeys {
                        insertData.setValue(objectRecord.value(forKey: key as! String), forKey: key as! String)
                    }
                }
                
                do {
                    try context.save()
                    insertSuccess = true
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            else {
                
                for insertData in results {
                    for i:NSInteger in 0 ..< entityData.count {
                        let objectRecord:NSDictionary = entityData.object(at: i) as! NSDictionary
                        for key in objectRecord.allKeys {
                            (insertData as AnyObject).setValue(objectRecord.value(forKey: key as! String), forKey: key as! String)
                        }
                    }
                }
                
                do {
                    try context.save()
                    insertSuccess = true
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            
        } catch  {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        return insertSuccess
    }
    
    //MARK: - Delete Record from CoreDatabase
    func DeleteTableFromCoreDatabase(entityName:NSString) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let arrDelete:NSArray = Coredatabase().fetchData(entityName: entityName, prediction: "")
        
        if arrDelete.count > 0 {
            for managedObjectContext in arrDelete {
                context.delete(managedObjectContext as! NSManagedObject)
            }
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
