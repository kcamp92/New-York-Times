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
           return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = #colorLiteral(red: 0.9330009818, green: 0.9096471667, blue: 0.8983025551, alpha: 1)
        textView.contentMode = .center
        return textView
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
        self.layer.cornerRadius = 20
    }
       private func addViews() {
           self.contentView.addSubview(bookImageView)
           self.contentView.addSubview(authorName)
           self.contentView.addSubview(descriptionTextView)

           
       }
    public func configureCell(with favoriteBook:FavoritesModel) {
        authorName.text = favoriteBook.authorName
        bookImageView.image = UIImage(data: favoriteBook.imageData)
        descriptionTextView.text = favoriteBook.description
           
        
       }
       
       private func configureConstraints() {
           bookImageView.translatesAutoresizingMaskIntoConstraints = false
           authorName.translatesAutoresizingMaskIntoConstraints = false
          descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    
           
           NSLayoutConstraint.activate([
               
//               bookImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//               bookImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
//               bookImageView.widthAnchor.constraint(equalToConstant: 100),
//               bookImageView.heightAnchor.constraint(equalToConstant: 200),
//               bookImageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor,constant: 20),
//            bookImageView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor,constant: 20),
//               weeksOnTopLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//               weeksOnTopLabel.centerYAnchor.constraint(equalTo: self.bookImageView.bottomAnchor, constant: 30),
//
//               descriptionTextView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//               descriptionTextView.topAnchor.constraint(equalTo: weeksOnTopLabel.bottomAnchor, constant: 30),
            
            
            bookImageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor,constant: 10),
            bookImageView.centerXAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerXAnchor),
            bookImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            bookImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.4),
            //weeksOnTopLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            authorName.topAnchor.constraint(equalTo: bookImageView.bottomAnchor,constant: 10),
            authorName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            authorName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: authorName.bottomAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
            
             
           ])
       }
}

