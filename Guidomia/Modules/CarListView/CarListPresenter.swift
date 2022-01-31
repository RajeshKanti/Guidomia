//
//  CarListPresenter.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-27.
//

import Foundation
import UIKit

protocol CarListPresentationLogic {
    func presentLoadScene(_ response: CarList.LoadScene.Response)
}

class CarListPresenter:  CarListPresentationLogic {
    weak var viewController: CarListDisplayLogic?

    func presentLoadScene(_ response: CarList.LoadScene.Response) {
        
        //Create table cell model
        var carListCellModels = [CarCellModel]()
        for car in response.carList {
            let prosTitle = car.prosList.count > 0 ? "Pros :" : ""
            let consTitle = car.consList.count > 0 ? "Cons :" : ""
            let carPrice = "Price : \(car.customerPrice / 1000)k"
            let prosAttributedText = getBulletAttributedText(dataArray: car.prosList)
            let consAttributedText = getBulletAttributedText(dataArray: car.consList)
            
            let carCellVM = CarCellModel(image: UIImage(named: "\(car.model)") ?? UIImage(), name: car.model, price: carPrice, starCount: car.rating, prosTitle: prosTitle, consTitle: consTitle, prosAttributedStr: prosAttributedText, consAttributedStr: consAttributedText)
            carListCellModels.append(carCellVM)
        }
        let viewModel = CarList.LoadScene.ViewModel(carList: carListCellModels)
        
        DispatchQueue.main.async {
            self.viewController?.displayLoadScene(viewModel)
        }
    }
    
    private func getBulletAttributedText(dataArray: [String]) -> NSMutableAttributedString {

        let text = NSMutableAttributedString()

        for data in dataArray {
            if data != "" {
                text.append(NSAttributedString(string: "\u{2022} ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)]))

                text.append(NSAttributedString(string: data + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]))
            }
        }
        return text
    }
}
