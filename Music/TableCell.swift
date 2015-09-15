//
//  TableCell.swift
//  Music
//
//  Created by 麻炜怡 on 9/15/15.
//  Copyright © 2015 CodeMonkey. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    override func layoutSubviews() {
        let image: UIImage? = (self.imageView?.image)
        self.imageView?.image = UIImage(named: "headerImage")
        super.layoutSubviews()
        self.imageView?.image = image
    }
}