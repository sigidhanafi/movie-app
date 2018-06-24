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
    
    var sections = [String]()
    var movie = [String: String]()
    var movies = [Movie]()
    
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
        
        let newestCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        newestCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        newestCollectionView.delegate = self
        newestCollectionView.dataSource = self
        newestCollectionView.backgroundColor = UIColor.black
        newestCollectionView.translatesAutoresizingMaskIntoConstraints = false
        newestCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
        self.stackView.addArrangedSubview(newestCollectionView)
        
        let relatedCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        relatedCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        relatedCollectionView.backgroundColor = UIColor.black
        relatedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        relatedCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
        self.stackView.addArrangedSubview(relatedCollectionView)

    }
    
    func loadData() {
        let provider = MoyaProvider<NetworkProvider>()
        provider.request(.popular) { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(response.data)
                let responseResults = responseJSON["results"]
                print(responseJSON)
                for (_, resultDict) in responseResults {
                    let id = resultDict["id"].stringValue
                    let title = resultDict["title"].stringValue
                    let image = "jurassic-park"
                    let dataMovie = Movie(id: id, title: title, image: image)
                    self.movies.append(dataMovie)
                }
                self.popularCollectionView.reloadData()
                
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
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        let title = movies[indexPath.row].title
        let image = movies[indexPath.row].image
        cell.titleLabel.text = title
        cell.coverImage.image = UIImage(named: "\(image)")
        
        return cell
    }
    
}

