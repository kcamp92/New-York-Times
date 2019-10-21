//
//  DetailViewController.swift
//  NewYorkTimes
//
//  Created by Michelle Cueva on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    public enum Saved {
           case yes
           case no
       }
    
    var bookData:BestSellers! {
        didSet {
            loadGoogleBookData()
        }
    }
    var googleBook:Books! {
        didSet {
            setUpInfo()
        }
    }
   
    lazy var saveButton:UIBarButtonItem  = {
        let sb = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonAction))
           return sb
       }()
    
    lazy var tappedAmazonSymbol: UITapGestureRecognizer = {
           let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapGestureTapped))
           
           return tapGesture
       }()
    
    lazy var bookImageView: UIImageView = {
              let image = UIImageView()
        image.image = UIImage(named: "bookPlaceHolder")
        image.clipsToBounds = true
        
              image.contentMode = .scaleToFill
              return image
       }()
       
       lazy var authorLabel: UILabel = {
              let label = UILabel()
              label.numberOfLines = 2
              label.textAlignment = .center
              label.textColor = .black
              label.adjustsFontSizeToFitWidth = true
              return label
       }()
       
       lazy var descriptionTextView: UITextView = {
           let textView = UITextView()
           textView.isScrollEnabled = true
           textView.isEditable = false
        textView.backgroundColor = .white
           textView.contentMode = .center
        textView.textColor = .black
           return textView
       }()
    
    lazy var amazonImage:UIImageView = {
        let ai = UIImageView()
        ai.contentMode = .scaleAspectFit
        ai.image = UIImage(named: "amazon")
        ai.addGestureRecognizer(self.tappedAmazonSymbol)
        ai.isUserInteractionEnabled = true

        return ai
    }()
       override func viewDidLoad() {
              super.viewDidLoad()
              view.backgroundColor = .white
        setUpConstraints()
        saveButton.isEnabled = false
           
              // Do any additional setup after loading the view.
          }
    private func loadGoogleBookData() {
        GoogleBookAPI.shared.getGoogleBookData(book: bookData) { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let success):
                self.googleBook = success[0].volumeInfo
            }
        }
    }
    
    @objc private func tapGestureTapped() {
          print("tapped")
       amazonSiteAlert()
      }
      
    private func amazonSiteAlert() {
        let alert = UIAlertController(title: "Are You Sure?", message:"You Will Leave The App And Enter An Unaffiliated Website", preferredStyle: .actionSheet)
              
              let okAction = UIAlertAction(title: "Leave App", style: .destructive) { (action) in
                  guard let urlStr = URL(string:self.bookData.amazon_product_url) else {return}
                  UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
              }
              let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
              alert.addAction(okAction)
              alert.addAction(cancel)
              present(alert,animated: true)
    }
    
    private func showAlert(if saved: Saved) {
        switch saved {
            
        case .yes:
            let alert = UIAlertController(title: "Sorry", message: "This is already in your favorites", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        case .no:
            let alert = UIAlertController(title: "YES!", message: "You have saved \"\(self.googleBook.title)\"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
       
    }
        
    }
    private func optionsAlert() {
           let alert = UIAlertController(title: "Options", message: "Click 'favorite' to save the current book", preferredStyle: .actionSheet)
        
        
           let save = UIAlertAction(title: "Favorite", style: .default) { (action) in
            
            if let existInFaves = self.googleBook.existsInFavorites() {
                switch existInFaves {
                case false:
                     let newFavoriteBook = FavoritesModel(imageData: self.bookImageView.image!.pngData()!, authorName: self.authorLabel.text!, description: self.descriptionTextView.text!, amazonUrl: self.bookData.amazon_product_url)
                               
                              try? BookPersistenceManager.manager.save(newBook: newFavoriteBook)
                     self.showAlert(if: .no)
                case true:
                    self.showAlert(if: .yes)
                    
                }
            }
           
           }
        
        let amazonAlert = UIAlertAction(title: "See On Amazon", style: .default) { (action) in
            guard let urlStr = URL(string:self.bookData.amazon_product_url) else {return}
            
            UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(save)
        alert.addAction(cancel)
        alert.addAction(amazonAlert)
        present(alert,animated: true)
       }
    
       @objc private func saveButtonAction() {
           optionsAlert()
       }
    
   
        
    private func setUpInfo() {
        ImageHelper.shared.getImage(urlStr: googleBook.imageLinks.thumbnail) { (results) in
            DispatchQueue.main.async {
            switch results {
            case .failure(let error):
                print(error)
            case .success(let image):
                self.bookImageView.image = image
                self.saveButton.isEnabled = true
            }
            }
        }
        authorLabel.text = googleBook.returnAuthors()
        
        descriptionTextView.text = googleBook.description
        navigationItem.title = googleBook.title
    }
    
    private func setUpConstraints() {
        self.navigationItem.rightBarButtonItem = saveButton

        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        amazonImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookImageView)
        view.addSubview(authorLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(amazonImage)
        
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),
            bookImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 60),
            bookImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -60),
            bookImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            amazonImage.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor,constant: 5),
            amazonImage.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            amazonImage.heightAnchor.constraint(equalToConstant: 50),
            amazonImage.widthAnchor.constraint(equalToConstant: 50),

            authorLabel.topAnchor.constraint(equalTo: self.bookImageView.bottomAnchor,constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: self.authorLabel.safeAreaLayoutGuide.bottomAnchor,constant: 10),
                       descriptionTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
                       descriptionTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
                    
                       descriptionTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
