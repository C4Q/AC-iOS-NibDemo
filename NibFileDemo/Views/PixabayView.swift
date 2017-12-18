//
//  PixabayView.swift
//  NibFileDemo
//
//  Created by C4Q  on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class PixabayView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) { //Storyboard init
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("PixabayView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func configureSelf(from pixabay: Pixabay) {
        ImageAPIClient.manager.loadImage(from: pixabay.webformatURL,
                                         completionHandler: {
                                            self.imageView.image = $0
                                            self.imageView.setNeedsLayout()
                                            self.likesLabel.text = "\(pixabay.likes) Likes"
                                            self.tagsLabel.text = pixabay.tags
                                            self.isHidden = false
        },
                                         errorHandler: {print($0)})
    }
    /*
     override init(frame: CGRect) { //Programmatic init
     
     }
     */
}
