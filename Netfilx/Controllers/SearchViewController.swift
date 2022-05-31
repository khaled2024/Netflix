//
//  SearchViewController.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 26/05/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - var & outlet
    private var titles : [Title] = [Title]()
    private let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifer)
        return tableView
    }()
    private let searchController : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        let searchBar = UISearchController(searchResultsController: controller)
        controller.searchBar.placeholder = "Search for a Movie or Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        searchTableView.delegate = self
        searchTableView.dataSource = self
        view.addSubview(searchTableView)
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        fetchDiscoverMovies()
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTableView.frame = view.bounds
    }
    //MARK: - private func
    func fetchDiscoverMovies(){
        ApiCaller.shared.discoverMovies {[weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.searchTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: - extensins
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifer, for: indexPath)as? TitleTableViewCell else{
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: UpcomingTitle(posterUrl:title.poster_path ?? "" , titleName: title.original_name ?? title.original_title ?? "UnKnown name"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let titleName = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title else {return}
        ApiCaller.shared.getMovie(with: titleName + "trailer" ) {[weak self] result in
            switch result{
            case .success(let video):
                let title = self?.titles[indexPath.row]
                guard let titleOverView = title?.overview else{return}
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: video, overTitle: titleOverView)
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                    vc.configure(with: viewModel)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
}
extension SearchViewController: UISearchResultsUpdating , SearchResultViewControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text ,
              !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else{return}
        resultController.delegate = self
        ApiCaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultController.titles = titles
                    resultController.searchCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    func SearchResultViewControllerDelegateTapped(viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
