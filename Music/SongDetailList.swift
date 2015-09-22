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
    var songString: NSString
    var songMp3: NSString
    override init() {
        self.songIDS = NSMutableArray()
        self.songTimes = NSMutableArray()
        self.songNames = NSMutableArray()
        self.songMp3Url = NSMutableArray()
        self.songString = NSString()
        self.songMp3 = NSString()
    }

}
