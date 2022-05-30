//
//  UpcomingViewController.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 26/05/2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    private let UpcomingTable: UITableView = {
        let table = UITableView()
        table.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifer)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(UpcomingTable)
        UpcomingTable.delegate = self
        UpcomingTable.dataSource = self
        self.fechUpcomingData()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UpcomingTable.frame = view.bounds
    }
    //MARK: - private func
    
    func fechUpcomingData(){
        ApiCaller.shared.getUpcomingMovies { result in
            switch result{
            case .success(let titles):
                self.titles = titles
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
      
    }
}
extension UpcomingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifer, for: indexPath)as? UpcomingTableViewCell else{
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: UpcomingTitle(posterUrl: title.poster_path ?? "" , titleName: title.original_name ?? title.original_title ?? "UnKnown name"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
