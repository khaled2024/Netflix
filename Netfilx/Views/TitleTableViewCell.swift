//
//  UpcomingTableViewCell.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 29/05/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifer = "UpcomingTableViewCell"

    private let playBtn: UIButton = {
        let btn = UIButton()
        let imageBtn = UIImage(systemName: "play.circle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        btn.setImage(imageBtn, for: .normal)
        btn.tintColor = UIColor.white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let posterImageView: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        return posterImage
    }()
    private let titleLable: UILabel = {
        let lable = UILabel()
        lable.lineBreakMode = .byWordWrapping
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(playBtn)
        
        applayConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - private func
    private  func applayConstrains(){
        let posterImageViewConstrains = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        let titleLableConstrains = [
            titleLable.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50)
        ]
        let playBtnConstrains = [
            playBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ]
        NSLayoutConstraint.activate(posterImageViewConstrains)
        NSLayoutConstraint.activate(titleLableConstrains)
        NSLayoutConstraint.activate(playBtnConstrains)
    }
    public func configure(with model: UpcomingTitle){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterUrl)")else{return}
        self.posterImageView.sd_setImage(with: url, completed: nil)
        self.titleLable.text = model.titleName
    }
}

