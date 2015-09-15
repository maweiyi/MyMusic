//
//  TopPlayLists.swift
//  Music
//
//  Created by 麻炜怡 on 9/12/15.
//  Copyright (c) 2015 CodeMonkey. All rights reserved.
//

import UIKit

class TopPlayLists: NSObject {
    var listId: NSMutableArray
    var listImage: NSMutableArray
    var listName: NSMutableArray
    
    override init() {
        self.listId = NSMutableArray()
        self.listImage = NSMutableArray()
        self.listName = NSMutableArray()
    }
   
}
