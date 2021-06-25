//
//  WorkImage+CoreDataClass.swift
//  Homehut
//
//  Created by Jacob Fink on 6/24/21.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(WorkImage)
public class WorkImage: NSManagedObject {

    var image: UIImage {
        get { return UIImage(data: imageData!) ?? UIImage() }
        set { imageData = newValue.jpegData(compressionQuality: 1.0) }
    }
}
