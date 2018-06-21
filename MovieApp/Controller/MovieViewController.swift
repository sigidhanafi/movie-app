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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        
        sections = ["Popular", "Action", "Drama", "Kids", "Horor"]
    
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
        
        let uiCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        uiCollectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        uiCollectionView.delegate = self
        uiCollectionView.dataSource = self
        uiCollectionView.backgroundColor = UIColor.black
        self.stackView.addArrangedSubview(uiCollectionView)
        
        uiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        uiCollectionView.heightAnchor.constraint(equalToConstant: layout.itemSize.height + 20).isActive = true
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.green
        self.stackView.addArrangedSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.heightAnchor.constraint(equalToConstant: 250).isActive = true

        let view3 = UIView()
        view3.backgroundColor = UIColor.cyan
        self.stackView.addArrangedSubview(view3)
        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.heightAnchor.constraint(equalToConstant: 250).isActive = true

        let view4 = UIView()
        view4.backgroundColor = UIColor.white
        self.stackView.addArrangedSubview(view4)
        view4.translatesAutoresizingMaskIntoConstraints = false
        view4.heightAnchor.constraint(equalToConstant: 250).isActive = true

        
    }

}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        return cell
    }
    
}

//class MovieCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    let wordLabel: UILabel = {
//        let label = UILabel()
//        label.text = "TEST TEST TEST"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    func setupView() {
//        backgroundColor = .yellow
//
//        addSubview(wordLabel)
//        wordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

