//
//  HeroesCollectionViewController.swift
//  SuperHeroes
//
//  Created by Artem Zhuzhgin on 23.01.2022.
//

import UIKit



class HeroesCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "superhero"

    private var superheroes: [Superhero] = []

    let numberOfItem: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getHeroes()
    
    }

 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        superheroes.count
       
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
       let superhero = superheroes[indexPath.item]
        let imageUrl = superhero.images.lg
        cell.getImage(for: imageUrl)
        
        cell.backgroundColor = .black
    
        return cell
    }
    
    
    
    func getHeroes(){
        NetworkingNavigator.shared.fetchData(for: "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json") { (result) in
            switch result {
            
            case .success(let superheroes):
                self.superheroes = superheroes
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
//    func getImage(for url: String) -> UIImage {
//        guard let url = URL(string: url) else {return}
//        var image: UIImage
//        NetworkingNavigator.shared.fetchImage(for: url) { (result) in
//            switch result {
//
//            case .success(let data):
//                image = UIImage(data: data) ?? <#default value#>
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        return image
//
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (numberOfItem + 1)
        let allItemsWidth = collectionView.frame.width - paddingWidth
        let itemWidth = allItemsWidth / numberOfItem
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         sectionInserts
    }
}
