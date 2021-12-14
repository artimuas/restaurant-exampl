//
//  RestaurantListViewController.swift
//  DoorDash-Test
//
//  Created by Saumitra Vaidya on 12/7/21.
//

import Foundation
import UIKit
import CoreLocation

class RestaurantListViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
//    private var searchController: UISearchController!
        
    private let viewModel = RestaurantListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        loadData()
    }
    
    @objc func loadData() {
        tableView.refreshControl?.beginRefreshing()
        viewModel.fetchRestaurants(forLocation: .current) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                switch result {
                case .success(_):
                    self.updateView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

// MARK: Table View DataSource
extension RestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel.itemViewModel(atIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantListViewCell
        cell.configure(withViewModel: cellViewModel)
        
        return cell
    }
}

// MARK: Table View Delegate
extension RestaurantListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
}

// MARK: View Configurations
extension RestaurantListViewController {
    private func configureView() {
        // Configure Header Label
        headerLabel.text = String(format: "Found %d businesses near the location.", viewModel.restaurants.count)
        
        // Configure Table View
        tableView.register(UINib(nibName: String(describing: RestaurantListViewCell.self), bundle: .main), forCellReuseIdentifier: "RestaurantCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(loadData),
                                            for: .valueChanged)
//        tableView.tableHeaderView = nil
//        tableView.contentInset = UIEdgeInsets(top: 250, left: 0, bottom: 0, right: 0)
//        let imageView = UIImageView(image: UIImage(named: "menu.jpg"))
//        imageView.frame = CGRect(x: 0, y: 0, width: 500, height: 300)
//        tableView.addSubview(imageView)
        
        
        // Configure Search Controller
//        searchController = UISearchController(searchResultsController: self)
//        searchController.delegate = self
//        searchController.searchBar.delegate = self
//        navigationItem.searchController = searchController
    }
    
    private func updateView() {
        headerLabel.text = String(format: "Found %d businesses near the location.", viewModel.restaurants.count)
        self.tableView.reloadData()
    }
}
