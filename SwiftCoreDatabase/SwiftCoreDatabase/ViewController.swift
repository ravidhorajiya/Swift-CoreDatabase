//
//  ViewController.swift
//  SwiftCoreDatabase
//
//  Created by Ravi Dhorajiya on 18/09/17.
//  Copyright © 2017 Ravi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InsertAndUpdateRecordsInTable()
        self.FetchTable()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func InsertAndUpdateRecordsInTable() {
        let dictTemp:NSMutableDictionary = NSMutableDictionary.init()
        dictTemp.setValue("3", forKey: "uid");
        dictTemp.setValue("Ravi", forKey: "name");
        dictTemp.setValue("Surat", forKey: "address");
        
        let arrTemp:NSMutableArray = NSMutableArray.init()
        arrTemp.add(dictTemp)
        var checkStore:Bool = false
        checkStore = Coredatabase().InsertAndUpdateData(entityData: arrTemp, entityName: "StoreData", prediction: "")
        print(checkStore)
        if checkStore == true {
            print("Insert successfully")
        }
        else
        {
            print("Records not inserted")
        }
    }
    
    func FetchTable() {
        let arrCheck:NSArray = Coredatabase().fetchData(entityName: "StoreData", prediction: "")
        print(arrCheck)
        print(arrCheck.count)
    }
    
    func DeleteTable() {
        Coredatabase().DeleteTableFromCoreDatabase(entityName: "StoreData")
    }
    
    func SingleRecordsDelete() {
        Coredatabase().SingleRecordsDeleteTableFromCoreDatabase(entityName: "StoreData", prediction: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

