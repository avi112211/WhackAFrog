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

class DataManger {
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

}
