# Swift-CoreDatabase
Insert, Update, Delete and Fetch from CoreDatabase.

# Insert & Update Records in table
```
func InsertAndUpdateRecordsInTable() {
    let dictTemp:NSMutableDictionary = NSMutableDictionary.init()
    dictTemp.setValue("1", forKey: "uid");
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
```
# Fetch Records
```
func FetchTable() {
    let arrCheck:NSArray = Coredatabase().fetchData(entityName: "StoreData", prediction: "")
    print(arrCheck)
    print(arrCheck.count)
}
```
