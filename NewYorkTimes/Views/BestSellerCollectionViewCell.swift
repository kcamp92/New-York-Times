//
//  BestSellerCollectionViewCell.swift
//  NewYorkTimes
//
//  Created by Michelle Cueva on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

class BestSellerCollectionViewCell: UICollectionViewCell {
    
    
    lazy var bookImageView: UIImageView = {
           let image = UIImageView()
           image.clipsToBounds = true
           image.contentMode = .scaleAspectFill
           return image
    }()
    
    lazy var weeksOnTopLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           label.textAlignment = .center
           label.textColor = .black
           label.adjustsFontSizeToFitWidth = true
           return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func addViews() {
           self.contentView.addSubview(bookImageView)
           self.contentView.addSubview(weeksOnTopLabel)
           self.contentView.addSubview(descriptionTextView)

           
       }
       
       private func configureConstraints() {
           bookImageView.translatesAutoresizingMaskIntoConstraints = false
           weeksOnTopLabel.translatesAutoresizingMaskIntoConstraints = false
           descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
    
           
           NSLayoutConstraint.activate([
               
               bookImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
               bookImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
               bookImageView.widthAnchor.constraint(equalToConstant: 100),
               bookImageView.heightAnchor.constraint(equalToConstant: 200),
               
               weeksOnTopLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
               weeksOnTopLabel.centerYAnchor.constraint(equalTo: self.bookImageView.bottomAnchor, constant: 30),
               
               descriptionTextView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
               descriptionTextView.topAnchor.constraint(equalTo: weeksOnTopLabel.bottomAnchor, constant: 30),
               
             
           ])
       }
}
