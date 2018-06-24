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
    var upcomingCollectionView: UICollectionView!
    
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    var upcomingMovies = [Movie]()
    
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
        
        upcomingCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        upcomingCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.backgroundColor = UIColor.black
        upcomingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        upcomingCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
        self.stackView.addArrangedSubview(upcomingCollectionView)
        
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
        
        provider.request(.upcoming) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                print(responseJSON)
                let responseResults = responseJSON["results"]
                print(responseResults)
                for (_, resultDict) in responseResults {
                    let id = resultDict["id"].stringValue
                    let title = resultDict["title"].stringValue
                    let image = "jurassic-park"
                    let dataMovie = Movie(id: id, title: title, image: image)
                    self.upcomingMovies.append(dataMovie)
                }
                self.upcomingCollectionView.reloadData()

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
        case self.popularCollectionView:
            return self.popularMovies.count
        case self.upcomingCollectionView:
            return self.upcomingMovies.count
        case self.topRatedCollectionView:
            return self.topRatedMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView {
        case self.popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            let title = self.popularMovies[indexPath.row].title
            let image = self.popularMovies[indexPath.row].image
            cell.titleLabel.text = title
            cell.coverImage.image = UIImage(named: "\(image)")
            return cell
        case self.upcomingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            let title = self.upcomingMovies[indexPath.row].title
            let image = self.upcomingMovies[indexPath.row].image
            cell.titleLabel.text = title
            cell.coverImage.image = UIImage(named: "\(image)")
            return cell
        case self.topRatedCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            let title = self.topRatedMovies[indexPath.row].title
            let image = self.topRatedMovies[indexPath.row].image
            cell.titleLabel.text = title
            cell.coverImage.image = UIImage(named: "\(image)")
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            let title = ""
            let image = ""
            cell.titleLabel.text = title
            cell.coverImage.image = UIImage(named: "\(image)")
            return cell
        }
        
//        title = popularMovies[indexPath.row].title
//        image = popularMovies[indexPath.row].image
//        cell.titleLabel.text = title
//        cell.coverImage.image = UIImage(named: "\(image)")
        
        
    }
    
}

