//
//  FavoritesCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by Phoenix McKnight on 10/19/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate:AnyObject {
    func actionSheet(tag:Int)
}

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    lazy var bookImageView: UIImageView = {
           let image = UIImageView()
           image.clipsToBounds = true
           image.contentMode = .scaleToFill
           return image
    }()
    
    lazy var authorName: UILabel = {
           let label = UILabel()
           label.numberOfLines = 2
           label.textAlignment = .center
           label.textColor = .black
           label.adjustsFontSizeToFitWidth = true
           label.alpha = 0
           return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = #colorLiteral(red: 0.9330009818, green: 0.9096471667, blue: 0.8983025551, alpha: 1)
        textView.contentMode = .center
        textView.alpha = 0
        textView.font = .systemFont(ofSize: 17)
        return textView
    }()
    lazy var actionSheetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Options", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.alpha = 0
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.alpha = 0
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var changeColorOfBorderCellFunction: (()->()) = {}

    weak var delegate:FavoriteCellDelegate?
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
        configureCloseButtonConstraints()
        actionSheetButtonConstraints()
        
        self.layer.cornerRadius = 20
        CustomLayer.shared.createCustomlayer(layer: self.layer, shadowOpacity: 0.5)
   
    }
    
    
    private enum State {
         case expanded
         case collapsed
         
         var change: State {
             switch self {
             case .expanded:
                 return .collapsed
             case .collapsed:
                 return .expanded
             }
         }
     }
     
     //Mark: Properties
     
     private var initialFrame: CGRect?
     private var state: State = .collapsed
     private var collectionView: UICollectionView?
     private var index: Int?
     
     //MARK: Cell Animations
     
     private func collapse() {
         
         UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
             guard let collectionView = self.collectionView, let index = self.index else {return}
             
            self.actionSheetButton.alpha = 0
             self.authorName.alpha = 0
            self.descriptionTextView.alpha = 0
             self.closeButton.alpha = 0
            self.bookImageView.transform = CGAffineTransform(translationX: 0, y: 0)
//            self.bookImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.descriptionTextView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.authorName.transform = CGAffineTransform(translationX: 0, y:0)
            CustomLayer.shared.createCustomlayer(layer: self.layer, shadowOpacity: 0.5)
             
             self.frame = self.initialFrame!
             
             if let upCell = collectionView.cellForItem(at: IndexPath.init(row: index - 1, section: 0)) {
                 //Animates Left Cell fading out when cell expands
                 
                 UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                     upCell.center.y += 50
                     upCell.alpha = 1
                 }, completion: nil)
             }
             
             if let downCell = collectionView.cellForItem(at: IndexPath.init(row: index + 1, section: 0)) {
                 
                 UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                     downCell.center.y -= 50
                     downCell.alpha = 1
                 }, completion: nil)
                 
             }
            
            if let secDownCell = collectionView.cellForItem(at: IndexPath.init(row: index + 2, section: 0)) {
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                    secDownCell.center.y -= 50
                    secDownCell.alpha = 1
                }, completion: nil)
                
            }
             
             self.layoutIfNeeded()
         }) { (finished) in
             self.state = self.state.change
             self.collectionView?.isScrollEnabled = true
             self.collectionView?.allowsSelection = true
         }
         
     }
     
     private func expand() {
         UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
             guard let collectionView = self.collectionView, let index = self.index else {return}
             
             self.initialFrame = self.frame
            self.actionSheetButton.alpha = 1
             self.authorName.alpha = 1
             self.descriptionTextView.alpha = 1
             self.closeButton.alpha = 1
            self.bookImageView.transform = CGAffineTransform(translationX: 0, y:-225)
            self.authorName.transform = CGAffineTransform(translationX: 0, y:-200)
            self.descriptionTextView.transform = CGAffineTransform(translationX: 0, y:-200)
//            self.bookImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            CustomLayer.shared.createCustomlayer(layer: self.layer, shadowOpacity: 0)
            
             
             self.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
             
             if let upCell = collectionView.cellForItem(at: IndexPath.init(row: index - 1, section: 0)) {
                 //Animates Left Cell fading out when cell expands
                 
                 UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                     upCell.center.y -= 50
                     upCell.alpha = 0
                 }, completion: nil)
             }
             
             if let downCell = collectionView.cellForItem(at: IndexPath.init(row: index + 1, section: 0)) {
                 
                 UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                     downCell.center.y += 50
                     downCell.alpha = 0
                 }, completion: nil)
             }
            
            if let secDownCell = collectionView.cellForItem(at: IndexPath.init(row: index + 2, section: 0)) {
                            
                            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                                secDownCell.center.y += 50
                                secDownCell.alpha = 0
                            }, completion: nil)
                        }
             
             self.layoutIfNeeded()
             
         }) { (finished) in
             self.state = self.state.change
             self.collectionView?.isScrollEnabled = false
             self.collectionView?.allowsSelection = false
         }
     }
    
    @objc func closeButtonPressed() {
            toggle()
        }
    
    @objc func actionButtonPressed(_ sender:UIButton) {
        print("Button pressed")
        delegate?.actionSheet(tag: sender.tag)
    }
        
        public func toggle() {
            switch state {
            case .expanded:
                collapse()
            case .collapsed:
                expand()
            }
        }
    
       private func addViews() {
           self.contentView.addSubview(bookImageView)
           self.contentView.addSubview(authorName)
           self.contentView.addSubview(descriptionTextView)

           
       }
    public func configureCell(with favoriteBook:FavoritesModel, collectionView: UICollectionView, index: Int) {
        authorName.text = favoriteBook.authorName
        bookImageView.image = UIImage(data: favoriteBook.imageData)
        descriptionTextView.text = favoriteBook.description
        self.collectionView = collectionView
        self.index = index
           
        
       }
    
    private func configureCloseButtonConstraints() {
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor), closeButton.widthAnchor.constraint(equalToConstant: 40), closeButton.topAnchor.constraint(equalTo: self.topAnchor), closeButton.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func actionSheetButtonConstraints() {
        addSubview(actionSheetButton)
        actionSheetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([actionSheetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10), actionSheetButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)])
    }

       
       private func configureConstraints() {
           bookImageView.translatesAutoresizingMaskIntoConstraints = false
           authorName.translatesAutoresizingMaskIntoConstraints = false
          descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    
           
           NSLayoutConstraint.activate([
               
            
            
            bookImageView.centerYAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerYAnchor),
            bookImageView.centerXAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerXAnchor),
            bookImageView.heightAnchor.constraint(equalToConstant: 200),
            bookImageView.widthAnchor.constraint(equalToConstant: 150),
            //weeksOnTopLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            authorName.topAnchor.constraint(equalTo: bookImageView.bottomAnchor,constant: 10),
            authorName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            authorName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: authorName.bottomAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 370)
            
             
           ])
       }
}


