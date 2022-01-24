//
//  CollectionViewCell.swift
//  SuperHeroes
//
//  Created by Artem Zhuzhgin on 23.01.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImageView: UIImageView!
    
    private var imageURL: URL? {
        didSet {
            heroImageView.image = nil
            updateImage()
            
        }
    }
    
    func configCell(superHero: Superhero) {
        imageURL = URL(string: superHero.images.lg)
        
    }
    
    func updateImage() {
        guard let url = imageURL else {return}
        getImage(for: url) { (result) in
            switch result {
            
            case .success(let image):
                if url == self.imageURL {
                    self.heroImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getImage(for url: URL, complition: @escaping(Result<UIImage,NetError>) -> Void)  {
        
        
        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("image from Cache", url.lastPathComponent)
            complition(.success(cacheImage))
            return
        }
 
        NetworkingNavigator.shared.fetchImage(for: url) { (result) in
            switch result {
            
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    complition(.failure(.decodingError))
                    return
                }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                print("image from network: ", url.lastPathComponent)
                complition(.success(image))
            case .failure(let error):
                complition(.failure(error))
            }
        }
       
        
    }

    
    
}
