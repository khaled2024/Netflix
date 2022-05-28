//
//  HomeViewController.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 26/05/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - vars & outlets
    let sectionTitles: [String] = ["Trending movies","Trending tv" ,"Popular" , "Upcoming movies","Top rated"]
    private let HomeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(HomeFeedTable)
        HomeFeedTable.delegate = self
        HomeFeedTable.dataSource = self
        configureNavBar()
        let headerView = HeroHeaderUiView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        HomeFeedTable.tableHeaderView = headerView
        feachData()
    }
    
    override func viewDidLayoutSubviews() {
        HomeFeedTable.frame = view.bounds
        HomeFeedTable.tableHeaderView?.backgroundColor = .clear
    }
    
    //MARK: - private func
    private func configureNavBar(){
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    private func feachData(){
        //        ApiCaller.shared.getTrendingMovies { result in
        //            switch result{
        //            case .success(let movie):
        //                print(movie)
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
        //        ApiCaller.shared.getTrendingTv { _ in
        //
        //        }
        //
        //        ApiCaller.shared.getUpcomingMovies { _ in
        //
        //        }
        //        ApiCaller.shared.getPopularMovies { _ in
        //
        //        }
        ApiCaller.shared.getTopRatedMovies { _ in
            
        }
    }
}

//MARK: - Exctensions
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath)as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //for customizing the header of section
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capatlizeFirstLetter()
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 15, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
    // for tite of each sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    // scroll direction when i scroll out of navBar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}
