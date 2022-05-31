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
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifer)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .white
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
                print(titles)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifer, for: indexPath)as? TitleTableViewCell else{
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: UpcomingTitle(posterUrl: title.poster_path ?? "" , titleName: title.original_name ?? title.original_title ?? "UnKnown name"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
