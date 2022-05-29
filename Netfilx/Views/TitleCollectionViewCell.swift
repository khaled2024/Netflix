//
//  TitleCollectionViewCell.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 29/05/2022.
//

import UIKit
import SDWebImage
class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
       let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        
        return posterImage
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    //MARK: -  private func
    func configure(with model: String){
        print(model)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)")else{return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
