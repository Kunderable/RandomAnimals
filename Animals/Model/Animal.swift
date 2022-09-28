//
//  Animal.swift
//  Animals
//
//  Created by Илья Сутормин on 28.09.2022.
//

import CoreData

class Animal: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var latinName: String?
    @NSManaged var lengthMin: String?
    @NSManaged var lengthMax: String?
    @NSManaged var geoRange: String?
    @NSManaged var diet: String?
    @NSManaged var imageLink: String?
    
    func from(_ animal: AnimalsModel) {
        name = animal.name
        latinName = animal.latinName
        lengthMin = animal.lengthMin
        lengthMax = animal.lengthMax
        geoRange = animal.geoRange
        diet = animal.diet
        imageLink = animal.imageLink
    }
}
