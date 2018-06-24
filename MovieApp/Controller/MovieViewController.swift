//
//  ViewController.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 6/12/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class MovieViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    var popularCollectionView: UICollectionView!
    var topRatedCollectionView: UICollectionView!
    var latestCollectionView: UICollectionView!
    
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    var latestMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"

        self.setupView()
        self.loadData()
        
    }
    
    func setupView() {
        let view1 = Bundle.main.loadNibNamed("View", owner: self, options: nil)?.first as! UIView
        self.stackView.addArrangedSubview(view1)
        view1.backgroundColor = UIColor.cyan
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 250)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        
        popularCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        popularCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.backgroundColor = UIColor.black
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
        self.stackView.addArrangedSubview(popularCollectionView)
        
        latestCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        latestCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        latestCollectionView.delegate = self
        latestCollectionView.dataSource = self
        latestCollectionView.backgroundColor = UIColor.black
        latestCollectionView.translatesAutoresizingMaskIntoConstraints = false
        latestCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
        self.stackView.addArrangedSubview(latestCollectionView)
        
        topRatedCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        topRatedCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
        topRatedCollectionView.backgroundColor = UIColor.black
        topRatedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topRatedCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
        self.stackView.addArrangedSubview(topRatedCollectionView)

    }
    
    func loadData() {
        let provider = MoyaProvider<NetworkProvider>()
        provider.request(.popular) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseResults = responseJSON["results"]
                for (_, resultDict) in responseResults {
                    let id = resultDict["id"].stringValue
                    let title = resultDict["title"].stringValue
                    let image = "jurassic-park"
                    let dataMovie = Movie(id: id, title: title, image: image)
                    self.popularMovies.append(dataMovie)
                }
                self.popularCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        provider.request(.latest) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseResults = responseJSON["results"]
                for (_, resultDict) in responseResults {
                    let id = resultDict["id"].stringValue
                    let title = resultDict["title"].stringValue
                    let image = "jurassic-park"
                    let dataMovie = Movie(id: id, title: title, image: image)
                    self.latestMovies.append(dataMovie)
                }
                self.latestCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        provider.request(.topRated) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseResults = responseJSON["results"]
                for (_, resultDict) in responseResults {
                    let id = resultDict["id"].stringValue
                    let title = resultDict["title"].stringValue
                    let image = "jurassic-park"
                    let dataMovie = Movie(id: id, title: title, image: image)
                    self.topRatedMovies.append(dataMovie)
                }
                self.topRatedCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case popularCollectionView:
            return popularMovies.count
        case latestCollectionView:
            return latestMovies.count
        case topRatedCollectionView:
            return topRatedMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        var title: String
        var image: String
        
        switch collectionView {
        case popularCollectionView:
            title = popularMovies[indexPath.row].title
            image = popularMovies[indexPath.row].image
        case latestCollectionView:
            title = latestMovies[indexPath.row].title
            image = latestMovies[indexPath.row].image
        case topRatedCollectionView:
            title = topRatedMovies[indexPath.row].title
            image = topRatedMovies[indexPath.row].image
        default:
            title = ""
            image = ""
        }
        
        cell.titleLabel.text = title
        cell.coverImage.image = UIImage(named: "\(image)")
        
        return cell
    }
    
}

