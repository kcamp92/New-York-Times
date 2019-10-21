//
//  SettingsViewController.swift
//  NewYorkTimes
//
//  Created by Michelle Cueva on 10/18/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var settings = [Results]() {
        didSet {
            genrePickerView.reloadAllComponents()
        }
    }
    var currentRow:Int! {
        didSet {
            UserDefaultsWrapper.shared.store(rowOfPickedGenre: self.currentRow)
        }
    }
    var displayCurrentGenre:String! {
        didSet {
             genreLabel.text = "You have selected: \(displayCurrentGenre.capitalized)"
            UserDefaultsWrapper.shared.store(displayNameGenre: self.displayCurrentGenre)
        }
    }
    var listedCurrentGenre:String! {
        didSet {
            UserDefaultsWrapper.shared.store(listGenre: self.listedCurrentGenre)
        }
    }
    
    var genrePickerView:UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pv.sizeToFit()
        return pv
    }()
    
    var genreLabel:UILabel = {
        let gl = UILabel()
        
        gl.textColor = .black
        gl.textAlignment = .center
        gl.text = "Pick a Genre"
        return gl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        checkUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genrePickerView.delegate
         = self
        genrePickerView.dataSource = self
        view.backgroundColor = .white
setUpConstraints()
       
        // Do any additional setup after loading the view.
    }
    
   
    
    private func checkUserDefaults() {
            listedCurrentGenre = UserDefaultsWrapper.shared.getListedGenre()!
        displayCurrentGenre = UserDefaultsWrapper.shared.getDisplayGenre()
               
               currentRow = UserDefaultsWrapper.shared.getCurrentRow()!
               
               genrePickerView.selectRow(currentRow, inComponent: 0, animated: true)
        
           }
 
   
    private func loadData() {
         settings = try! GenrePersistenceManager.manager.getGenreList()
    }
    private func setUpConstraints() {
         genrePickerView.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(genreLabel)
        self.view.addSubview(genrePickerView)
        
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 75),
                      genreLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                       genreLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                       genreLabel.heightAnchor.constraint(equalToConstant: 50),
            genrePickerView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor,constant: 10),
            genrePickerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            genrePickerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            genrePickerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)



        
            
        ])
    }
  

}
extension SettingsViewController:UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settings.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return settings[row].displayName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if settings.count > 0 {
            
            displayCurrentGenre = settings[row].displayName
            listedCurrentGenre = settings[row].listName
            currentRow = row
        }
    }

}
//class SettingsViewController: UIViewController {
//    //MARK: - Properties
//    var settingCategories = [Category](){
//        didSet{
//            DispatchQueue.main.async {
//                self.categoryPickerView.reloadAllComponents()
//            }
//        }
//    }
//
//    lazy var pickCategoryLabel: UILabel = {
//        let categoryLabel = UILabel()
//        categoryLabel.text = "Pick Default Category"
//        categoryLabel.textColor = .white
//        categoryLabel.font = categoryLabel.font.withSize(24)
//        return categoryLabel
//    }()
//
//    private func categoryLabelConstraint() {
//        pickCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            pickCategoryLabel.heightAnchor.constraint(equalToConstant: 50),
//            pickCategoryLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -180),
//            pickCategoryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            pickCategoryLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -350)
//        ])
//    }
//
//    lazy var categoryPickerView: UIPickerView = {
//        let categoryPV = UIPickerView()
//        categoryPV.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        categoryPV.tintColor = .purple
//        return categoryPV
//    }()
//
//    private func categoryPVConstraint() {
//        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            categoryPickerView.heightAnchor.constraint(equalToConstant: 350),
//            categoryPickerView.widthAnchor.constraint(equalToConstant: 350),
//            categoryPickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            categoryPickerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
//        ])
//
//    }
//
//
//    private func setUpConstraints(){
//        categoryLabelConstraint()
//        categoryPVConstraint()
//    }
//    private func addSubviews(){
//        view.addSubview(pickCategoryLabel)
//        view.addSubview(categoryPickerView)
//    }
//
//    override func viewDidLoad() {
//        addSubviews()
//        setUpConstraints()
//        categoryPickerView.dataSource = self
//        categoryPickerView.delegate = self
//        super.viewDidLoad()
//    }
//}
//extension SettingsViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return settingCategories.count
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return settingCategories[row].list_name_encoded
//    }
//
//}
//extension SettingsViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        UserDefaults.standard.set(settingCategories[row].list_name_encoded, forKey: "BooksList")
//        UserDefaults.standard.set(String(row), forKey: "PickerView")//set new file name
//
//    }
//}
//
