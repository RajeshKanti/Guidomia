//
//  CustomerHeaderView.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-29.
//

import UIKit

class HeaderTableViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var carMakeSearchBar: UISearchBar!
    @IBOutlet weak var carModelSearchBar: UISearchBar!
    @IBOutlet weak var filterContainerView: UIView! {
        didSet {
            filterContainerView.layer.cornerRadius = 10.0
        }
    }
    
    var carMakeCompletion: ((String) -> Void)?
    var carModelCompletion: ((String) -> Void)?

    func setupCell(carMakeCompletionHandler: @escaping ((String) -> Void), carModelCompletionHanlder: @escaping (String) -> Void) {
        
        carMakeCompletion = carMakeCompletionHandler
        carModelCompletion = carModelCompletionHanlder
    }
}

extension HeaderTableViewCell: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if searchBar == carMakeSearchBar {
            let newSearchedString = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
            carMakeCompletion?(newSearchedString)
        } else if searchBar == carModelSearchBar {
            let newSearchedString = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
            carModelCompletion?(newSearchedString)
        }
        
        return true
    }
}

