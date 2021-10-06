//
//  BeerListViewController.swift
//  Spindox-ios-challenge
//
//  Created by Fernando Menendez on 05/10/2021.
//

import UIKit

class BeerListViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController()
    
    // Dependencies
    var viewModel : BeerListViewModel = BeerListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavigationBar()
        configureSearchView()
        configureBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
    private func configureNavigationBar() {
        navigationController?.title = "Beers"
    }
    
    private func configureSearchView() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func configureCollectionView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BeerTableViewCell",
                                      bundle: nil),
                           forCellReuseIdentifier: BeerTableViewCell.identifier)
    }
    
    private func configureBindings() {
        viewModel.isError.bind { [weak self] isError in
            guard let self = self, isError else {
                return
            }
            let alert = UIAlertController(title: "Error",
                                          message: "There is an Error Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again",
                                          style: .default,
                                          handler: { _ in self.viewModel.fetchData() }))
            self.present(alert, animated: true)
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else {
                return
            }
            if isLoading {
                self.present(self.loadingView, animated: true)
            } else {
                self.loadingView.dismiss(animated: true)
            }
        }
        
        viewModel.filteredBeers.bind { [weak self] _ in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
        }
    }
    
    let loadingView : UIAlertController = {
        let alert = UIAlertController(title: nil,
                                      message: "Please wait...",
                                      preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()
}

extension BeerListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 163.0
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension BeerListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.beersCount
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier,
                                                 for: indexPath) as! BeerTableViewCell
        let beer = viewModel.beer(for: indexPath)
        cell.nameLabel.text = beer.name
        cell.descLabel.text = beer.beerDescription
        cell.tagLineLabel.text = beer.tagline
        cell.alcoholLabel.text = String(beer.abv)
        cell.image = beer.imageURL
        return cell
    }
}

extension BeerListViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              text.count > 0 else {
            return
        }
        viewModel.filter(with: text)
    }
    
}
