//
//  ViewController.swift
//  NewYorkTimes
//
//  Created by Krystal Campbell on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

class BestSellersViewController: UIViewController {
var animationRunning = false
    var genreData = [Categories]() {
        didSet {
            settingsPickerView.reloadAllComponents()
            
            try? GenrePersistenceManager.manager.save(genreList: self.genreData)
                
            }
        }
    
        var bestSellers = [BestSellers]() {
            didSet {
               
                self.bestSellerCollectionView.reloadData()
                }
            }
    
    var googleBooks:Items! {
        didSet {
            bestSellerCollectionView.reloadData()
        }
    }
    
        
        //MARK: Miscellaneous Variables
         
       var currentRow:Int! {
              didSet {
                 checkPersistence()
                UserDefaultsWrapper.shared.store(rowOfPickedGenre: self.currentRow)
              }
          }
          var displayCurrentGenre:String! {
              didSet {
                navigationItem.title = self.displayCurrentGenre
                UserDefaultsWrapper.shared.store(displayNameGenre: self.displayCurrentGenre)
              }
          }
          var listedCurrentGenre:String! {
              didSet {
                loadBestSellingData()
                  UserDefaultsWrapper.shared.store(listGenre: self.listedCurrentGenre)
              }
          }
        
        //MARK: Outlet Variables
        
      lazy var initialLabel:UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = label.font.withSize(20)
           // label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.font = UIFont(name: "Marker Felt", size: 27.0)
            label.text = "The NY Times Best Sellers"
            return label
        }()
        
        lazy var placeHolderImage:UIImageView = {
               
               let image = UIImageView()
               image.image = UIImage(named: "bookPlaceHolder")
           
               return image
           }()
        
        
        lazy var bestSellerCollectionView:UICollectionView = {
            var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
            let colletionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout )
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 250, height: 300)
            colletionView.register(BestSellerCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCollectionViews.bestSellerCollectionView.rawValue)
            colletionView.dataSource = self
            colletionView.delegate = self
            colletionView.backgroundColor = .clear
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            return colletionView
        }()
        
        lazy var settingsPickerView:UIPickerView = {
            let pv = UIPickerView()
            pv.delegate = self
            pv.dataSource = self
            pv.backgroundColor = .white
            return pv
            
        }()
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            checkUserDefaults()
//            settingsPersistenceHelper()
//            bestSellerCollectionView.reloadData()
//
//        }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUserDefaults()
    }
        
       
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            addSubViews()
            createCityLabelConstraints()
            createCollectionViewOutletConstraints()
            createPickerViewConstraints()
           
            
            //placeHolderAnimation()
        }
      
    private func checkUserDefaults() {
        if UserDefaultsWrapper.shared.getListedGenre() == nil {  listedCurrentGenre = "combined-print-and-e-book-fiction"
            navigationItem.title = "Combined Print & E-Book Fiction"
            currentRow = 1
        } else {
            listedCurrentGenre = UserDefaultsWrapper.shared.getListedGenre()!
            displayCurrentGenre = UserDefaultsWrapper.shared.getDisplayGenre() ?? "Combined Print & E-Book Fiction"
            
            currentRow = UserDefaultsWrapper.shared.getCurrentRow()!
            
            settingsPickerView.selectRow(currentRow, inComponent: 0, animated: true)
        }

        
       
    }
    private func checkPersistence() {
        if try! GenrePersistenceManager.manager.getGenreList().count == 0  {
        loadSettingsData()
        } else {
            self.genreData = try! GenrePersistenceManager.manager.getGenreList()
        }
    }
        
        //MARK: Functions - Button Actions
    
       
        //MARK: Functions - Constraints
        
      private  func createCityLabelConstraints() {
            
            initialLabel.translatesAutoresizingMaskIntoConstraints = false
            initialLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 50).isActive = true
            initialLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            initialLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            initialLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        }
      private  func setUpPlaceHolder() {
               placeHolderImage.translatesAutoresizingMaskIntoConstraints = false
               
               placeHolderImage.centerYAnchor.constraint(equalTo: bestSellerCollectionView.centerYAnchor).isActive = true
               placeHolderImage.centerXAnchor.constraint(equalTo: bestSellerCollectionView.centerXAnchor).isActive = true
               placeHolderImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
               placeHolderImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
              
           }
      private  func createCollectionViewOutletConstraints() {
            bestSellerCollectionView.translatesAutoresizingMaskIntoConstraints = false
            bestSellerCollectionView.topAnchor.constraint(equalTo: initialLabel.bottomAnchor).isActive = true
            bestSellerCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
            bestSellerCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
       bestSellerCollectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        }
        
     private   func createPickerViewConstraints() {
          
            settingsPickerView.translatesAutoresizingMaskIntoConstraints = false
            settingsPickerView.topAnchor.constraint(equalTo: bestSellerCollectionView.bottomAnchor,constant: 30).isActive = true
        settingsPickerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
         settingsPickerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        settingsPickerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
        }
    
        //MARK:Functions - Animations
      
           
        
      private  func placeHolderAnimation() {

        UIView.transition(with: self.placeHolderImage, duration: 4.0, options: [.transitionCrossDissolve], animations: {
            self.animationRunning = true
             self.placeHolderImage.image = UIImage(named: "clear")
        }, completion: { (_) in
            self.animationRunning = false
        })
       
           }
        
        
        //MARK: Functions - Miscellaneous
        
     private   func addSubViews() {
               view.addSubview(initialLabel)
               view.addSubview(bestSellerCollectionView)
            view.addSubview(placeHolderImage)
               view.addSubview(settingsPickerView)
        }
        
        
        private func loadSettingsData() {
            GenreListAPIClient.shared.getGenreList() { (results) in
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.genreData = data
            }
        }
    }
    
   
    private func loadBestSellingData() {
        NYTAPIClient.shared.getBestSellerList(genre: self.listedCurrentGenre) { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.bestSellers = data
            }
        }
    }
}
    //MARK: Extensions

    
    
    
    extension BestSellersViewController: UICollectionViewDataSource,UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return bestSellers.count
        }

        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let bestSelling = bestSellers[indexPath.row]
            let cell = bestSellerCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCollectionViews.bestSellerCollectionView.rawValue, for: indexPath) as! BestSellerCollectionViewCell

               
            cell.backgroundColor = #colorLiteral(red: 0.9330009818, green: 0.9096471667, blue: 0.8983025551, alpha: 1)
            
           cell.configureCell(with: bestSelling, collectionView: bestSellerCollectionView, index: indexPath.row)
            cell.changeColorOfBorderCellFunction = {
                CustomLayer.shared.createCustomlayer(layer: cell.layer, shadowOpacity: 0.5)
            }
            cell.changeColorOfBorderCellFunction()
           
            GoogleBookAPI.shared.getGoogleBookData(book: bestSelling) { (results) in
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    if let image = data[0].volumeInfo?.imageLinks.thumbnail {
                    ImageHelper.shared.getImage(urlStr: image) { (results) in
                        DispatchQueue.main.async {
                        switch results {
                        case .failure(let error):
                            print(error)
                        case .success(let imageData):
                            cell.bookImageView.image = imageData
                        }
                    }
                        }
                }
            }
            }
            
        
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let detailVC = DetailViewController()
            detailVC.bookData = bestSellers[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
}
       

extension BestSellersViewController:UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genreData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genreData[row].displayName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        listedCurrentGenre = genreData[row].listName
        displayCurrentGenre = genreData[row].displayName
        currentRow = row
        navigationItem.title = genreData[row].displayName.capitalized
    }

}
