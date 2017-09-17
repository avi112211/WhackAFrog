//
//  DataManager.swift
//  WhackAFrog
//
//  Created by Yael on 05/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class DataManager {
    //manage default frog picture
    static let pictureFileName:String = "tempSavedImage"
    
    static var applicationLibraryPath: NSString = {
        if let libraryDirectoryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last {
            return libraryDirectoryPath as NSString
        }
        return ""
    }()
    
    static func saveImage(_ imageToSave: UIImage, toFile filename: String) -> Bool {
        if let data = UIImagePNGRepresentation(imageToSave) {
            do {
                try data.write(to: URL(fileURLWithPath: (applicationLibraryPath as String) + "/" + filename), options: .atomicWrite)
                return true
            } catch {
            }
        }
        
        return false
    }
    
    static func loadImage(fromFile filename: String) -> UIImage? {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: (applicationLibraryPath as String) + "/" + filename)) {
            return UIImage(data: data)
        }
        return nil
    }
    //
    
   
    
    //manage records
    static let recordsKey:String = "Record"
    static let maxRecords:Int = 10
    
    static func saveRecord(name: String, score: Int, lng: Double, lat: Double)->Bool{
        let newRecord = MyRecord(name: name, score: score, lng: lng, lat: lat)
        var allRecords = loadRecords()
        
        //chack no more then 10 recors
        if(allRecords.count == maxRecords){
            //if more - delete one
            let index = deleteMinRecord(allRecords: allRecords)
            if(index > -1){
                allRecords[index] = newRecord
            }
            //cant be something else
        }
        else{
            allRecords.append(newRecord)
        }
        
        UserDefaults.standard.set(allRecords.map{$0.dictionary}, forKey: recordsKey)
        return UserDefaults.standard.synchronize()
    }
    
    static func loadRecords()->[MyRecord]{
        if let allRecods = UserDefaults.standard.array(forKey: recordsKey) as? [Dictionary<String,Any>]{
            return allRecods.map{MyRecord(dictionary: $0)}
        }
        return []
    }

    static func checkMinRecord()->Int{
        let allRecords:[MyRecord] = loadRecords()
        if(allRecords.count < maxRecords){
            return -1;
        }
        var minScore:Int = allRecords[0].score
        for record in allRecords{
            if(record.score < minScore){
                minScore = record.score
            }
        }
        return minScore
    }
    
    static func deleteMinRecord(allRecords: [MyRecord])->Int{
        let minScore:Int = checkMinRecord()
        let allRecords:[MyRecord] = loadRecords()
        var index = 0
        
        for record in allRecords{
            if(record.score == minScore){
                return index
            }
            index+=1
        }
        
        return -1
    }
    
    //mannage gps popup alert
    static let gpsKey:String = "GpsPopUp"
    static let maxCount:Int = 3
    
    static func setGpsCount(count: Int)->Bool{
        let count = (count + 1) % maxCount
        UserDefaults.standard.set(count, forKey: gpsKey)
        return UserDefaults.standard.synchronize()
    }
    
    static func getGpsCount()->Int{
        if let gpsCount = UserDefaults.standard.object(forKey: gpsKey) as? Int{
            return gpsCount
        }
        return 0
    }
    
    static func showPopUp()->Bool{
        let count = getGpsCount()
        if(count == (maxCount - 1)){
            if(setGpsCount(count: count)){
                return true
            }
        }
        _=setGpsCount(count: count)
        return false
    }
}

class MyRecord : NSObject{
    static let kName:String = "name"
    static let kScore:String = "score"
    static let kLng:String = "lng"
    static let kLat:String = "lat"
    
    var name:String
    var score:Int
    var lng:Double
    var lat:Double
    
    var dictionary:[String:Any]{
        return self.dictionaryWithValues(forKeys: [MyRecord.kName, MyRecord.kScore, MyRecord.kLng, MyRecord.kLat])
    }
    
    init(name:String , score:Int, lng:Double , lat:Double) {
        self.name = name
        self.score = score
        self.lng = lng
        self.lat = lat
        super.init()
        
    }
    
    init(dictionary:[String:Any]){
        self.name = ""
        self.score = 0
        self.lng = 0
        self.lat = 0
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
