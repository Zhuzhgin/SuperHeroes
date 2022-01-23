//
//  CollectionViewCell.swift
//  SuperHeroes
//
//  Created by Artem Zhuzhgin on 23.01.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImageView: UIImageView!
    
    
    func getImage(for url: String)  {
        guard let url = URL(string: url) else {return}
 
        NetworkingNavigator.shared.fetchImage(for: url) { (result) in
            switch result {
            
            case .success(let data):
                
                self.heroImageView.image = UIImage(data: data)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
       
        
    }

    
    
}
