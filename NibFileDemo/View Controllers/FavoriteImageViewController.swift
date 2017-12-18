//
//  FavoriteImageViewController.swift
//  NibFileDemo
//
//  Created by C4Q  on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class FavoriteImageViewController: UIViewController {

    
    @IBOutlet weak var pixabayView: PixabayView!
    
    var pixabay: Pixabay! {
        didSet {
            pixabayView.likesLabel.text = "\(pixabay.likes) Likes"
            pixabayView.tagsLabel.text = pixabay.tags
            pixabayView.imageView.image = #imageLiteral(resourceName: "andy-lg")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTestPixabay()
    }
    
    func loadTestPixabay() {
        //self.pixabay = Pixabay.testPixabays[1]
    }

}
