//
//  TableViewController.swift
//  Animals
//
//  Created by Илья Сутормин on 28.09.2022.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class TableViewController: UITableViewController {

    @IBOutlet var tableVie: UITableView!
    
    var context: NSManagedObjectContext!
    var animals: [Animal]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
        tableVie.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Animal.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Animal", in: context)
        
        
        
        do {
            let result = try context!.fetch(fetchRequest) as! [Animal]
            
            if !result.isEmpty {
                animals = result
            }
        } catch {
                print(error)
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animals!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        guard let animalRow = animals![indexPath.row] as? Animal,
              let rowing = animalRow.name
        else { return cell }
                
        cell.textLabel?.text = rowing

        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let animal = animals![indexPath.row] as? Animal, editingStyle == .delete else { return }
            
        context.delete(animal)
        
        do {
            try context.save()
            tableVie.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print(error)
        }
    }
    

   

}
