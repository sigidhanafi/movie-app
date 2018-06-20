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
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.blue
        self.stackView.addArrangedSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.heightAnchor.constraint(equalToConstant: 200).isActive = true

        
    }

}

