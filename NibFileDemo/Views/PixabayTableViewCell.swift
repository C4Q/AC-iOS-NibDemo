//
//  PixabayTableViewCell.swift
//  NibFileDemo
//
//  Created by C4Q  on 12/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class PixabayTableViewCell: UITableViewCell {
    @IBOutlet weak var pixabayImageView: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    func configureCell(with pixabay: Pixabay) {
        self.tagsLabel.text = pixabay.tags
        self.likesLabel.text = "\(pixabay.likes) likes"
        ImageAPIClient.manager.loadImage(from: pixabay.webformatURL, completionHandler: {self.pixabayImageView.image = $0; self.pixabayImageView.setNeedsLayout()}, errorHandler: {print($0)})
    }
}
