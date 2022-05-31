//
//  TitlePreviewViewController.swift
//  Netfilx
//
//  Created by KhaleD HuSsien on 31/05/2022.
//

import UIKit
import WebKit
class TitlePreviewViewController: UIViewController {
    
    //MARK: - vars
    private let webKitView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    private let titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.font = .systemFont(ofSize: 22, weight: .bold)
        titleLable.text = "Harry Potter"
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        return titleLable
    }()
    private let overViewLable: UILabel = {
        let overViewLable = UILabel()
        overViewLable.font = .systemFont(ofSize: 18, weight: .regular)
        overViewLable.translatesAutoresizingMaskIntoConstraints = false
        overViewLable.numberOfLines = 0
        overViewLable.text = "This is the best movie you will watch as a kid.!This is the best movie you will watch as a kid.!This is the best movie you will watch as a kid.!This is the best movie you will watch as a kid.!This is the best movie you will watch as a kid.!This is the best movie you will watch as a kid.!"
        return overViewLable
    }()
    private let downloadBtn: UIButton = {
        let downloadBtn = UIButton()
        downloadBtn.translatesAutoresizingMaskIntoConstraints = false
        downloadBtn.backgroundColor = .red
        downloadBtn.setTitle("Download", for: .normal)
        downloadBtn.layer.cornerRadius = 8
        downloadBtn.layer.masksToBounds = true
        //        downloadBtn.layer.shadowColor = UIColor.white.cgColor
        //        downloadBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        downloadBtn.setTitleColor(UIColor.white, for: .normal)
        return downloadBtn
    }()
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webKitView)
        view.addSubview(titleLable)
        view.addSubview(overViewLable)
        view.addSubview(downloadBtn)
        applyConstrains()
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - private func
    func applyConstrains(){
        let webKitViewConstrains = [
            webKitView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            webKitView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webKitView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webKitView.heightAnchor.constraint(equalToConstant: 300)
        ]
        let titleLableConstrains = [
            titleLable.topAnchor.constraint(equalTo: webKitView.bottomAnchor, constant: 20),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
        ]
        
        let overViewTitleConstrains = [
            overViewLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor , constant: 15),
            overViewLable.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            overViewLable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        let downloadBtnConstrains = [
            downloadBtn.topAnchor.constraint(equalTo: overViewLable.bottomAnchor , constant: 15),
            downloadBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadBtn.widthAnchor.constraint(equalToConstant: 120),
            downloadBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(webKitViewConstrains)
        NSLayoutConstraint.activate(titleLableConstrains)
        NSLayoutConstraint.activate(overViewTitleConstrains)
        NSLayoutConstraint.activate(downloadBtnConstrains)
    }
    func configure(with model: TitlePreviewViewModel){
        self.titleLable.text = model.title
        self.overViewLable.text = model.overTitle
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)")else{return}
        webKitView.load(URLRequest(url: url))
    }
}
