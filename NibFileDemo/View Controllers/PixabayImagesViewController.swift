//
//  PixabayImagesViewController.swift
//  NibFileDemo
//
//  Created by C4Q  on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class PixabayImagesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchTerm = "" {
        didSet {
            loadImages(named: searchTerm)
        }
    }
    
    var pixabays = [Pixabay]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PixabayTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Pixabay Cell")
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func loadImages(named str: String) {
        PixabayAPIClient.manager.getImages(named: str, completionHandler: {self.pixabays = $0}, errorHandler: {print($0)})
    }
}

extension PixabayImagesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let userSearchTerm = searchBar.text, userSearchTerm != "" {
            self.searchTerm = userSearchTerm
            resignFirstResponder()
        }
    }
}

extension PixabayImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pixabays.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pixabay = pixabays[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Pixabay Cell", for: indexPath) as! PixabayTableViewCell
        cell.imageView?.image = nil
        cell.configureCell(with: pixabay)
        return cell
    }
}

extension PixabayImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

