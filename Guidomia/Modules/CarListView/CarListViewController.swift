//
//  CarListViewController.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-26.
//

import UIKit

protocol CarListDisplayLogic: AnyObject {
    func displayLoadScene(_ viewModel: CarList.LoadScene.ViewModel)
}

class CarListViewController: UIViewController, CarListDisplayLogic {

    @IBOutlet weak var carsTableView: UITableView!
    
    var interactor: CarListBusinessLogic?
    var router: (CarListRoutingLogic & CarListDataPassing)?
    var cellData = [CarCellModel]()
    var selectedRowIndex = IndexPath(row: 0, section: 0)

    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = CarListInteracter()
        let presenter = CarListPresenter()
        let router = CarListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataSource = interactor
    }

    private func setupSubview() {
        carsTableView.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0);
        carsTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderTableViewCell")
        carsTableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarTableViewCell")

        carsTableView.sectionHeaderHeight = UITableView.automaticDimension
        carsTableView.rowHeight = UITableView.automaticDimension
        carsTableView.estimatedSectionHeaderHeight = 50.0
        carsTableView.estimatedRowHeight = 50.0
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubview()
        loadScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Use Cases
    
    func loadScene() {
        let request = CarList.LoadScene.Request(searchedMakeName: nil, searchedModelName: nil)
        interactor?.loadScene(request)
    }
    
    func displayLoadScene(_ viewModel: CarList.LoadScene.ViewModel) {
        cellData = viewModel.carList
        carsTableView.reloadData()
    }
}

// MARK: - Tableview Data Source and Delegate methods
extension CarListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell
        headerCell?.setupCell(carSearchCompletionHanlder: { [weak self] carMakeSearchKey, carModelSearchKey in
            let request = CarList.LoadScene.Request(searchedMakeName: carMakeSearchKey, searchedModelName: carModelSearchKey)
            self?.interactor?.loadScene(request)
        })
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as? CarTableViewCell else {
            return UITableViewCell()
        }
        
        cell.shouldExpandCell = (indexPath == selectedRowIndex)
        cell.setupCell(cellVM: cellData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndex = indexPath
        carsTableView.reloadData()
    }
}



