//
//  Network.swift
//  Animals
//
//  Created by Илья Сутормин on 28.09.2022.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class Network {
    static func fetch(url: String, completion: @escaping (AnimalsModel) -> ()) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let models  = try decoder.decode(AnimalsModel.self, from: data)
                completion(models)
                
                DispatchQueue.main.async {
                    if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext,
                       let entity = NSEntityDescription.insertNewObject(forEntityName: "Animal", into: context) as? Animal {
                        entity.from(models)
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
