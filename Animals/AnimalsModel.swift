//
//  AnimalsModel.swift
//  Animals
//
//  Created by Илья Сутормин on 28.09.2022.
//

import Foundation

struct AnimalsModel: Codable {
    
    let name: String?
    let latinName: String?
    let lengthMin: String?
    let lengthMax: String?
    let diet: String?
    let geoRange: String?
    let imageLink: String?
    
    enum CodingKeys: String, CodingKey {
            case name
            case latinName = "latin_name"
            case lengthMin = "length_min"
            case lengthMax = "length_max"
            case diet
            case geoRange = "geo_range"
            case imageLink = "image_link"
            
        }
}
