//
//  CarListRouter.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-27.
//

import Foundation

protocol CarListRoutingLogic {
    // Routing to other screens protocol needs to be declar here
    
}

protocol CarListDataPassing {
    var dataSource: CarListDataStore? { get set }
}

class CarListRouter: CarListRoutingLogic, CarListDataPassing {
    
    weak var viewController: CarListViewController?
    var dataSource: CarListDataStore?
    
    //Whenever need to route to other screens the logic needs to be implemented here
    
}
