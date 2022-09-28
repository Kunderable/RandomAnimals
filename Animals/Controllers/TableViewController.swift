//
//  TableViewController.swift
//  Animals
//
//  Created by Илья Сутормин on 28.09.2022.
//

import UIKit
import CoreData
import Kingfisher

@available(iOS 13.0, *)
class TableViewController: UITableViewController {

    var context: NSManagedObjectContext!
    var animals: [Animal]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Animal.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Animal", in: context)
        
        do {
            let result = try context!.fetch(fetchRequest) as! [Animal]
            
            if !result.isEmpty {
                animals = result
                try context.save()
            }
        
        } catch {
                print("error")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
               return animals?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
       guard let animalRow = animals?[indexPath.row] else { return cell }
        cell.nameLabel.text = animalRow.name
        cell.dietLabel.text = animalRow.diet
        cell.geiRangeLabel.text = animalRow.geoRange
        
        
        if cell.imageLabel != nil {
            let url = URL(string: animalRow.imageLink!)
            cell.imageLabel.kf.indicatorType = .activity
            cell.imageLabel.kf.setImage(with: url, options: [.transition(.fade(0.4)),
                                                             .processor(DownsamplingImageProcessor(size: cell.imageLabel.frame.size)),
                                                               .cacheOriginalImage])
        } else {
            let image = UIImage(named: "question")
            cell.imageLabel.image = image
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let animal = animals?[indexPath.row], editingStyle == .delete else { return }

        context.delete(animal)
        
        do {
            try context.save()
            animals?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
}
