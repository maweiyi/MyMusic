//
//  SongDetailList.swift
//  Music
//
//  Created by 麻炜怡 on 9/16/15.
//  Copyright © 2015 CodeMonkey. All rights reserved.
//

import UIKit

class SongDetailList: NSObject {
    var songIDS: NSMutableArray
    var songTimes: NSMutableArray
    var songNames: NSMutableArray
    var songMp3Url: NSMutableArray
    override init() {
        self.songIDS = NSMutableArray()
        self.songTimes = NSMutableArray()
        self.songNames = NSMutableArray()
        self.songMp3Url = NSMutableArray()
    }

}
