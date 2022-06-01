//
//  CollectionViewTableViewCell.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 27/05/2022.
//

import UIKit


protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCelltapped(cell: CollectionViewTableViewCell , viewModel: TitlePreviewViewModel)
}
class CollectionViewTableViewCell: UITableViewCell {
    
    //MARK: - vars & outlets
    static let identifier = "CollectionViewTableViewCell"
    private var titles: [Title] = [Title]()
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
        
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = contentView.bounds
    }
    //MARK: - private func
    public func configure(with titles: [Title]){
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    func downloadTitleAt(with indexPath: IndexPath){
     let title = titles[indexPath.row]
        DataPersistenceManager.shared.downloadTitle(with: title) { result in
            switch result{
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: - extensions
extension CollectionViewTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath)as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        guard let model = titles[indexPath.row].poster_path else{return UICollectionViewCell()}
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let titleName = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title else {return}
        ApiCaller.shared.getMovie(with: titleName + "trailer" ) {[weak self] result in
            switch result{
            case .success(let video):
                let title = self?.titles[indexPath.row]
                guard let titleOverView = title?.overview else{return}
                guard let strongSelf = self else{return}
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: video, overTitle: titleOverView)
                self?.delegate?.CollectionViewTableViewCelltapped(cell: strongSelf, viewModel: viewModel )
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // 3D touch for cell item indexPath
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
            let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadTitleAt(with: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
    }
}
