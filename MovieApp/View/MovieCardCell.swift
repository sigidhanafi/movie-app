//
//  MovieCardCell.swift
//  MovieApp
//
//  Created by Sigit Hanafi on 13/05/19.
//  Copyright © 2019 Sigit Hanafi. All rights reserved.
//

import AsyncDisplayKit

class MovieCardCell: ASCellNode {
    private let cardNode = ASDisplayNode()
    private let titleTextNode = ASTextNode()
    private let movieImageNode = ASNetworkImageNode()
    
    public var title: String
    public var imageUrl: String
    
    init(title: String, imageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
        
        super.init()
        self.automaticallyManagesSubnodes = true
        cardNode.automaticallyManagesSubnodes = true
        
        generateView()
    }
    
    func generateView() {
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.white
            ])
        
        titleTextNode.maximumNumberOfLines = 2
        
        movieImageNode.setURL(URL(string: imageUrl), resetToDefault: false)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        cardNode.style.width = ASDimensionMake(constrainedSize.max.width / 2 - 4)
        cardNode.style.height = ASDimensionMake(330)
        
        movieImageNode.style.width = ASDimensionMake(constrainedSize.max.width / 2)
        movieImageNode.style.height = ASDimensionMake(280)
        movieImageNode.contentMode = .scaleAspectFill
        
        cardNode.layoutSpecBlock = { (_, _) -> ASLayoutSpec in
            let titleTextInsetWrapper = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: self.titleTextNode)
            
            let verticalNodeWrapper = ASStackLayoutSpec.vertical()
            verticalNodeWrapper.children = [self.movieImageNode, titleTextInsetWrapper]
            
            return verticalNodeWrapper
        }
        
        return ASWrapperLayoutSpec(layoutElement: cardNode)
    }
}
