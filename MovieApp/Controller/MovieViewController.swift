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
    
    var movies = [MovieResult]()
    
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
    
    func loadData() {
        let useCase = DefaultMovieUseCase()
        useCase.loadPopular(page: "1") { (response) in
            let results = response.results
            self.movies = results
            self.movieCollectionView.reloadData()
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
        let imageUrl = "https://image.tmdb.org/t/p/w185/\(movies[indexPath.row].posterPath)"
        
        let cell = MovieCardCell(title: title, imageUrl: imageUrl)
        
        return {
            return cell
        }
    }
}
