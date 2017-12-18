//
//  ViewController.swift
//  NibFileDemo
//
//  Created by C4Q  on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class RandomImageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pixabayView: PixabayView!
    
    var searchTerm = "" {
        didSet {
            loadImage(named: searchTerm)
        }
    }
    
    var pixabay: Pixabay! {
        didSet {
            pixabayView.configureSelf(from: pixabay)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.pixabayView.isHidden = true
    }
    
    func loadImage(named str: String) {
        PixabayAPIClient.manager.getFirstImage(named: str, completionHandler: {self.pixabay = $0}, errorHandler: {print($0)})
    }

}

extension RandomImageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text {
            self.searchTerm = term
        }
    }
}
