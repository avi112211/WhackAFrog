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

//class GameRecord : NSManagedObject{
//    @NSManaged var name:String!
//    @NSManaged var score:String!
//    @NSManaged var lng:String!
//    @NSManaged var lat:String!
//
//
//
//}


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
    static let entityName:String = "Record"
    static let kName:String = "name"
    static let kScore:String = "score"
    static let kLng:String = "lng"
    static let kLat:String = "lat"
    
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var recordArray:[GameRecord] = []
    
    static func saveRecord(name: String, score: Int, lng: Double, lat: Double){
        let record = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        
        record.setValue(name, forKey: kName)
        record.setValue(score, forKey: kScore)
        record.setValue(lng, forKey: kLng)
        record.setValue(lat, forKey: kLat)

        do{
            try context.save()
        }
        catch{
            print("DataManager - Save error: \(error)")
        }
    }
    
    static func loadRecords()->[GameRecord]{
        fetchData()
        return recordArray
    }
    
    static func fetchData(){
        do{
            recordArray = try context.fetch(GameRecord.fetchRequest()) as? [NSManagedObject] as! [GameRecord]
        }
        catch{
            print("DataManager - FetchData: \(error)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
