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
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        cv.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViews.favoritesCollectionView.rawValue)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cv
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        favoritesConstraints()
        loadFavoritesData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            if self.favorites.count != 0 {
                self.introAlert()
            }
        }
        
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
    
    
    
    private func introAlert() {
        let alert = UIAlertController(title: "Favorites", message: "Click to delete or add to Amazon", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        present(alert,animated: true)
    }
    
    
    
    private func loadFavoritesData() {
        do {
            self.favorites = try BookPersistenceManager.manager.getFavoriteBook()
            if self.favorites.count == 0 {
                checkIfAnythingHasBeenFavorited()
            }
        } catch {
            print(error)
        }
    }
    
    private func checkIfAnythingHasBeenFavorited() {
        let alert = UIAlertController(title: "No Access!", message: "Please favorite a book to access the Favorites tab", preferredStyle: .alert)
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
        cell.configureCell(with: favs, collectionView: favoriteCollectionView, index: indexPath.row)
        cell.backgroundColor = #colorLiteral(red: 0.9330009818, green: 0.9096471667, blue: 0.8983025551, alpha: 1)
        cell.delegate = self
//        cell.changeColorOfBorderCellFunction = {
//            CustomLayer.shared.createCustomlayer(layer: cell.layer)
//        }
//        cell.changeColorOfBorderCellFunction()
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 350 , height: 300 )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! FavoritesCollectionViewCell
        selectedCell.toggle()
    }
    
    
}


extension FavoritesViewController:FavoriteCellDelegate {
    func actionSheet(tag: Int) {
        
        let alert = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            
            try? BookPersistenceManager.manager.deleteFavoriteBook(description: self.favorites[tag].description)
            self.favorites.remove(at: tag)
            self.loadFavoritesData()
            
            
        }
        
        let amazon = UIAlertAction(title: "See on Amazon", style: .default) { (action) in
            guard let urlStr = URL(string:self.favorites[tag].amazonUrl) else {return}
            
            UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
        }
        
        let review = UIAlertAction(title: "Leave a Review", style: .default) { (action) in
            guard let urlStr = URL(string:self.favorites[tag].reviewUrl) else {return}
            
            UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(amazon)
        alert.addAction(review)
        alert.addAction(delete)
        
        present(alert,animated: true)
    }
    
    //test commit here
    
}
