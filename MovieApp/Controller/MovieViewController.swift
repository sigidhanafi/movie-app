//
//  ViewController.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 6/12/18.
//  Copyright © 2018 Sigit Hanafi. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    var sections = [String]()
    var movie = [String: String]()
    var movies = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        
        let movie1: [String: String] = ["title": "Jurassic Park", "image": "jurassic-park"]
        movies.append(movie1)
        let movie2: [String: String] = ["title": "Jurassic World", "image": "jurassic-world"]
        movies.append(movie2)
        let movie3: [String: String] = ["title": "The Lost World", "image": "the-lost-world"]
        movies.append(movie3)
        let movie4: [String: String] = ["title": "Jurassic Park", "image": "jurassic-park"]
        movies.append(movie4)
        let movie5: [String: String] = ["title": "Jurassic World", "image": "jurassic-world"]
        movies.append(movie5)
        let movie6: [String: String] = ["title": "The Lost World", "image": "the-lost-world"]
        movies.append(movie6)
    
        self.setupView()
        
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
        
        let popularCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
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
        
//        let view2 = UIView()
//        view2.backgroundColor = UIColor.cyan
//        self.stackView.addArrangedSubview(view2)
//        view2.translatesAutoresizingMaskIntoConstraints = false
//        view2.heightAnchor.constraint(equalToConstant: 250).isActive = true
//
//        let view3 = UIView()
//        view3.backgroundColor = UIColor.white
//        self.stackView.addArrangedSubview(view3)
//        view3.translatesAutoresizingMaskIntoConstraints = false
//        view3.heightAnchor.constraint(equalToConstant: 250).isActive = true
//
//        let view4 = UIView()
//        view4.backgroundColor = UIColor.cyan
//        self.stackView.addArrangedSubview(view4)
//        view4.translatesAutoresizingMaskIntoConstraints = false
//        view4.heightAnchor.constraint(equalToConstant: 250).isActive = true
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
        
        if let title = movies[indexPath.row]["title"] {
            cell.titleLabel.text = title
        }
        
        if let image = movies[indexPath.row]["image"] {
            cell.coverImage.image = UIImage(named: "\(image)")
        }
        
        return cell
    }
    
}

