//
//  ViewController.swift
//  Animals
//
//  Created by Илья Сутормин on 28.09.2022.
//

import UIKit
import Kingfisher

@available(iOS 13.0, *)
class ViewController: UIViewController {
    private let apiURL = "https://zoo-animal-api.herokuapp.com/animals/rand"
    
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var titleAnimal: UILabel!
    @IBOutlet weak var nameLatin: UILabel!
    @IBOutlet weak var geoRangeLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
    @IBOutlet weak var lenghtMinLabel: UILabel!
    @IBOutlet weak var lenghtMaxLabel: UILabel!
    @IBOutlet weak var buttonOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedPressButton(buttonOut)
    }
    
    private func fetch() {
        Network.fetch(url: apiURL) { [weak self] animal in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                
                self.titleAnimal.text = animal.name
                self.nameLatin.text = animal.latinName
                self.geoRangeLabel.text = animal.geoRange
                self.dietLabel.text = animal.diet
                self.lenghtMinLabel.text = animal.lengthMin
                self.lenghtMaxLabel.text = animal.lengthMax
                
                let url = URL(string: animal.imageLink!)
                self.animalImage.kf.indicatorType = .activity
                self.animalImage.kf.setImage(with: url, options: [.transition(.fade(0.4)),
                                                                  .processor(DownsamplingImageProcessor(size: self.animalImage.frame.size)),
                                                                  .cacheOriginalImage])
            }
        }
    }
    
    @IBAction func searchedPressButton(_ sender: UIButton) {
        fetch()
    }
}

