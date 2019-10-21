//
//  FavoritesViewController.swift
//  NewYorkTimes
//
//  Created by Michelle Cueva on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    var favorites = [FavoritesModel]() {
        didSet {
            favoriteCollectionView.reloadData()
        }
    }
    lazy var favoriteCollectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 350)
        cv.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViews.favoritesCollectionView.rawValue)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
             view.backgroundColor = .white
        favoritesConstraints()
        loadFavoritesData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // Do any additional setup after loading the view.
    }
    
    private func favoritesConstraints() {
        favoriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favoriteCollectionView)
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            favoriteCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func introAlert() {
        let alert = UIAlertController(title: "Favorites", message: "Click to delete or add to Amazon", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert,animated: true)
    }
    
    
    
    private func loadFavoritesData() {
        do {
            let favoritedBooks = try BookPersistenceManager.manager.getFavoriteBook()
            if favoritedBooks.count == 0 {
                checkIfAnythingHasBeenFavorited()
            } else {
                self.favorites = favoritedBooks
                introAlert()
            }
        } catch {
            introAlert()
            print(error)
        }
        
    }
   
    private func checkIfAnythingHasBeenFavorited() {
           let alert = UIAlertController(title: "You cannot access this page", message: "Please favorite a book to access the Favorites tab", preferredStyle: .alert)
           let dismissAlert = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
               self.tabBarController?.selectedIndex = 0
               
           }
               alert.addAction(dismissAlert)
           present(alert,animated: true)
          
       }
}
extension FavoritesViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favs = favorites[indexPath.row]
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViews.favoritesCollectionView.rawValue, for: indexPath) as! FavoritesCollectionViewCell
        cell.configureCell(with: favs)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionSheet(tag: indexPath.row)
    }
    
    
}
extension FavoritesViewController:FavoriteCellDelegate {
    func actionSheet(tag: Int) {
        
            let alert = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                switch tag {
              
                case 1:
                    try? BookPersistenceManager.manager.deleteFavoriteBook(description: self.favorites[tag].description)
                                     self.favorites.remove(at: tag)
                    self.checkIfAnythingHasBeenFavorited()
                default:
                                  try? BookPersistenceManager.manager.deleteFavoriteBook(description: self.favorites[tag].description)
                                  self.favorites.remove(at: tag)
                }
                

            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(delete)
            alert.addAction(cancel)
            present(alert,animated: true)
        }
    
    //test commit here
    
}
