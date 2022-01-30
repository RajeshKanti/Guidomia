//
//  CustomerHeaderView.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-29.
//

import UIKit

class HeaderTableViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var carMakeSearchBar: UISearchBar! {
        didSet {
            carMakeSearchBar.setImage(UIImage(), for: .search, state: .normal)
            carMakeSearchBar.searchTextField.backgroundColor = .white
        }
    }
    @IBOutlet weak var carModelSearchBar: UISearchBar! {
        didSet {
            carModelSearchBar.setImage(UIImage(), for: .search, state: .normal)
            carModelSearchBar.searchTextField.backgroundColor = .white
        }
    }
    @IBOutlet weak var filterContainerView: UIView! {
        didSet {
            filterContainerView.layer.cornerRadius = 10.0
        }
    }
    
    var carSearchCompleHandler: ((String?, String?) -> Void)?
    
    func setupCell(carSearchCompletionHanlder: @escaping ((String?, String?) -> Void)) {
        carSearchCompleHandler = carSearchCompletionHanlder
    }
}

extension HeaderTableViewCell: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if searchBar == carMakeSearchBar {
            let carMakeSearchString = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
            carSearchCompleHandler?(carMakeSearchString, carModelSearchBar.text)
        } else if searchBar == carModelSearchBar {
            let carModelSearchString = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
            carSearchCompleHandler?(carMakeSearchBar.text, carModelSearchString)
        }
        
        return true
    }
}

