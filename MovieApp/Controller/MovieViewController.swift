//
//  ViewController.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 6/12/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import AsyncDisplayKit
import Moya
import SwiftyJSON

class MovieViewController: ASViewController<ASDisplayNode> {
    
    var movies = [Movie]()
    
    private let movieCollectionView: ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        return ASCollectionNode(collectionViewLayout: layout)
    }()
    private let textNode = ASTextNode()
    
    init() {
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        
        super.init(node: node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        navigationController?.navigationBar.isTranslucent = false
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        generateView()
        loadData()
    }
    
    func generateView() {
        movieCollectionView.backgroundColor = UIColor.black
        
        node.layoutSpecBlock = { (_, constrainedSize) -> ASLayoutSpec in
            return ASWrapperLayoutSpec(layoutElement: self.movieCollectionView)
        }
    }
    
}

extension MovieViewController: ASCollectionDelegate, ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let title = movies[indexPath.row].title
        let imageUrl = "https://image.tmdb.org/t/p/w185/\(movies[indexPath.row].image)"
        
        let cell = MovieCardCell(title: title, imageUrl: imageUrl)
        
        return {
            return cell
        }
    }

//    func setupView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 150, height: 250)
//        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 10
//
//        popularCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
//        popularCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
//        popularCollectionView.delegate = self
//        popularCollectionView.dataSource = self
//        popularCollectionView.backgroundColor = UIColor.black
//        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        popularCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
//        self.stackView.addArrangedSubview(popularCollectionView)
//
//        upcomingCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
//        upcomingCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
//        upcomingCollectionView.delegate = self
//        upcomingCollectionView.dataSource = self
//        upcomingCollectionView.backgroundColor = UIColor.black
//        upcomingCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        upcomingCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
//        self.stackView.addArrangedSubview(upcomingCollectionView)
//
//        topRatedCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
//        topRatedCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
//        topRatedCollectionView.delegate = self
//        topRatedCollectionView.dataSource = self
//        topRatedCollectionView.backgroundColor = UIColor.black
//        topRatedCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        topRatedCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
//        self.stackView.addArrangedSubview(topRatedCollectionView)
//
//    }

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
                    let image = resultDict["poster_path"].stringValue
                    let dataMovie = Movie(id: id, title: title, image: image)
                    self.movies.append(dataMovie)
                }
                self.movieCollectionView.reloadData()

            case .failure(let error):
                print(error)
            }
        }

//        provider.request(.upcoming) { result in
//            switch result {
//            case .success(let response):
//                let responseJSON = JSON(response.data)
//                let responseResults = responseJSON["results"]
//                for (_, resultDict) in responseResults {
//                    let id = resultDict["id"].stringValue
//                    let title = resultDict["title"].stringValue
//                    let image = resultDict["poster_path"].stringValue
//                    let dataMovie = Movie(id: id, title: title, image: image)
//                    self.upcomingMovies.append(dataMovie)
//                }
//                self.upcomingCollectionView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        provider.request(.topRated) { result in
//            switch result {
//            case .success(let response):
//                let responseJSON = JSON(response.data)
//                let responseResults = responseJSON["results"]
//                for (_, resultDict) in responseResults {
//                    let id = resultDict["id"].stringValue
//                    let title = resultDict["title"].stringValue
//                    let image = resultDict["poster_path"].stringValue
//                    let dataMovie = Movie(id: id, title: title, image: image)
//                    self.topRatedMovies.append(dataMovie)
//                }
//                self.topRatedCollectionView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

//
//extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case self.popularCollectionView:
//            return self.popularMovies.count
//        case self.upcomingCollectionView:
//            return self.upcomingMovies.count
//        case self.topRatedCollectionView:
//            return self.topRatedMovies.count
//        default:
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        switch collectionView {
//        case self.popularCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
//            let title = self.popularMovies[indexPath.row].title
//            let image = self.popularMovies[indexPath.row].image
//            cell.titleLabel.text = title
//            let imageUrl = "https://image.tmdb.org/t/p/w185/\(image)"
//            if let url = URL(string: imageUrl) {
//                downloadImage(url: url, onComplete: { (data) in
//                    DispatchQueue.main.async {
//                        let image = UIImage(data: data)
//                        cell.coverImage.image = image
//                    }
//                })
//            }
//
//            return cell
//        case self.upcomingCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
//            let title = self.upcomingMovies[indexPath.row].title
//            let image = self.upcomingMovies[indexPath.row].image
//            cell.titleLabel.text = title
//            let imageUrl = "https://image.tmdb.org/t/p/w185/\(image)"
//            if let url = URL(string: imageUrl) {
//                downloadImage(url: url, onComplete: { (data) in
//                    DispatchQueue.main.async {
//                        let image = UIImage(data: data)
//                        cell.coverImage.image = image
//                    }
//                })
//            }
//
//            return cell
//        case self.topRatedCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
//            let title = self.topRatedMovies[indexPath.row].title
//            let image = self.topRatedMovies[indexPath.row].image
//            cell.titleLabel.text = title
//            let imageUrl = "https://image.tmdb.org/t/p/w185/\(image)"
//            if let url = URL(string: imageUrl) {
//                downloadImage(url: url, onComplete: { (data) in
//                    DispatchQueue.main.async {
//                        let image = UIImage(data: data)
//                        cell.coverImage.image = image
//                    }
//                })
//            }
//
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
//            let title = ""
//            let image = ""
//            cell.titleLabel.text = title
//            cell.coverImage.image = UIImage(named: "\(image)")
//            return cell
//        }
//
//    }
//
//    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            completion(data, response, error)
//            }.resume()
//    }
//
//    func downloadImage(url: URL, onComplete: @escaping ((Data) -> Void)) {
//        getDataFromUrl(url: url) { data, response, error in
//            guard let data = data else { return }
//            onComplete(data)
//        }
//    }
//
//}
//
