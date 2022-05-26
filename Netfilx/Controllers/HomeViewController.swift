//
//  HomeViewController.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 26/05/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - vars & outlets
    private let HomeFeedTable:UITableView = {
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
    }
    
    override func viewDidLayoutSubviews() {
        HomeFeedTable.frame = view.bounds
        HomeFeedTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
    }
    
    //MARK: - private func
    
    
    
    
}

//MARK: - Exctensions
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
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
    
    
}
