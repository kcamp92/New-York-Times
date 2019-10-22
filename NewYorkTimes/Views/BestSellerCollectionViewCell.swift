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
           image.contentMode = .scaleToFill
           return image
    }()
    
    lazy var weeksOnTopLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 2
           label.textAlignment = .center
           label.textColor = .black
           label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Courier-Bold", size: 18.0)
           return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.contentMode = .center
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "Courier", size: 12.0)

        textView.textAlignment = .center
               textView.layer.cornerRadius = 20
        return textView
    }()
    
    var changeColorOfBorderCellFunction: (()->()) = {}

    var googleBookFunction: (()->()) = {}

    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
    }
       private func addViews() {
           self.contentView.addSubview(bookImageView)
           self.contentView.addSubview(weeksOnTopLabel)
           self.contentView.addSubview(descriptionTextView)

           
       }
    public func configureCell(with bestSellers:BestSellers ,collectionView:UICollectionView,index:Int) {
        weeksOnTopLabel.text = bestSellers.returnWeeksOnlistAsString(weeks: bestSellers.weeks_on_list)
           bookImageView.image = UIImage(named: "bookPlaceHolder")
        descriptionTextView.text = bestSellers.book_details[0].description
           //self.collectionView = collectionView
           //self.index = index
        
       }
       
       private func configureConstraints() {
           bookImageView.translatesAutoresizingMaskIntoConstraints = false
           weeksOnTopLabel.translatesAutoresizingMaskIntoConstraints = false
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
            weeksOnTopLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor,constant: 10),
            weeksOnTopLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            weeksOnTopLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: weeksOnTopLabel.bottomAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
            
             
           ])
       }
}
