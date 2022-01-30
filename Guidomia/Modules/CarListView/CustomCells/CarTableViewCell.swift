//
//  CarTableViewCell.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-26.
//

import UIKit

struct CarCellModel {
    let image: UIImage
    let name: String
    let price: String
    let starCount: Int
    let prosTitle: String
    let consTitle: String
    let prosAttributedStr: NSMutableAttributedString?
    let consAttributedStr: NSMutableAttributedString?
}

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var firstStart: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    @IBOutlet weak var prosTitleLabel: UILabel!
    @IBOutlet weak var prosDescLabel: UILabel!
    @IBOutlet weak var consTitleLabel: UILabel!
    @IBOutlet weak var consDescLabel: UILabel!
    @IBOutlet weak var proConsView: UIView!
    @IBOutlet weak var proConsViewHeightConstraint: NSLayoutConstraint!
    
    var shouldExpandCell = false

    func setupCell(cellVM: CarCellModel) {
        
        carImageView.image = cellVM.image
        carName.text = cellVM.name
        carPrice.text = cellVM.price
        firstStart.isHidden = cellVM.starCount < 1
        secondStar.isHidden = cellVM.starCount < 2
        thirdStar.isHidden = cellVM.starCount < 3
        fourthStar.isHidden = cellVM.starCount < 4
        fifthStar.isHidden = cellVM.starCount < 5
        
        if shouldExpandCell {
            proConsViewHeightConstraint.priority = .defaultLow
            proConsView.isHidden = false

            prosTitleLabel.text = cellVM.prosTitle
            prosDescLabel.attributedText = cellVM.prosAttributedStr
            consTitleLabel.text = cellVM.consTitle
            consDescLabel.attributedText = cellVM.consAttributedStr            
        } else {
            proConsViewHeightConstraint.constant = 0
            proConsViewHeightConstraint.priority = .defaultHigh
            proConsView.isHidden = true
        }
    }
}
