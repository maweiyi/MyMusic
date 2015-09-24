//
//  SongDetailViewController.swift
//  Music
//
//  Created by 麻炜怡 on 9/16/15.
//  Copyright © 2015 CodeMonkey. All rights reserved.
//

import UIKit
import AVFoundation

class SongDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var beginLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    @IBOutlet weak var songTimeSlider: UISlider!
    
    @IBOutlet weak var collectBtn: UIButton!
    
    @IBOutlet weak var downLoadBtn: UIButton!
    
    @IBOutlet weak var randomBtn: UIButton!
    
    @IBOutlet weak var preSongBtn: UIButton!
    @IBOutlet weak var playSongBtn: UIButton!
    @IBOutlet weak var nextSongBtn: UIButton!
    
    @IBAction func collectBtnAction(sender: AnyObject) {
    }
    
    @IBAction func downLoadAction(sender: AnyObject) {
    }
    @IBAction func randomBtnAction(sender: AnyObject) {
    }
    
    @IBAction func preBtnAction(sender: AnyObject) {
    }
    
    @IBAction func playActionBtn(sender: UIButton) {
        
               //sender.setImage(UIImage(named: "pause"), forState: UIControlState.Selected)
        sender.setBackgroundImage(UIImage(named: "play"), forState: UIControlState.Selected)
        sender.selected = !sender.selected
        self.stop();

    }
    
    @IBAction func nextSongAction(sender: AnyObject) {
    }
    
    
    @IBOutlet weak var showlyric: UITableView!
    
    var timeColock: NSTimer?
    
    var song: SongDetailList = SongDetailList()
    //歌词字符串
    var songLyric: NSString = NSString()
    var allCell: NSMutableArray = NSMutableArray()
    
    var lrcDictionary: NSMutableDictionary = NSMutableDictionary()
    var lyricArray: NSMutableArray = NSMutableArray()
    var array: NSArray = NSArray()
    var cellCount: NSInteger = 0

    
    var player: AVAudioPlayer?
    
    var time: NSMutableArray = NSMutableArray()
    var lyric: NSMutableArray = NSMutableArray()
    var datasong: NSData = NSData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //今天不想写
        print("\(self.song.songString)")
        self.songTimeSlider.setThumbImage(UIImage(named: "player-progress-point-h"), forState: UIControlState.Normal)
        
        self.showlyric.backgroundColor = UIColor.clearColor()
        self.showlyric.separatorStyle = UITableViewCellSeparatorStyle.None
        self.showlyric.hidden = true
        self.showlyric.delegate = self
        self.showlyric.dataSource = self
        self.showlyric.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
        self.getLyric()
        
        
        print("self.lyricArray\(self.array.count)")
        let url: NSURL = NSURL(string: self.song.songMp3 as String)!
        let data: NSData = NSData(contentsOfURL: url)!
        self.datasong = data
        
        self.beginLabel.text = "00:00";
        self.endLabel.text = self.changeTime(self.song.songTime) as String
        self.beginPlay()
    
    }
    
    func changeTime(timeString: NSString) -> NSString {
        
        var totalTime: NSInteger = NSInteger()
        totalTime = timeString.integerValue
        let totalSeconds: Int = totalTime / 1000
        let minutes: NSInteger = totalSeconds / 60
        let seconds: NSInteger = totalSeconds % 60
        
        let time: NSString = (NSString(format: "%d", minutes) as String) + ":" + (NSString(format: "%d", seconds) as String)
        
        return time
        
        
    }

    func updateTime() {
        
        print("Maweiyi")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getLyric() {
        
        let dictionary: NSDictionary = NSDictionary(object: self.song.songString, forKey: "id")
        var jsonData: NSData = NSData()
        
        do {
            
            jsonData = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
        } catch {
            
        }
        
        let stringUrl: NSString = NSString(string: "http://127.0.0.1:8000/music/hello4/")
        let url: NSURL = NSURL(string: stringUrl as String)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = jsonData
        
        let session: NSURLSession = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
           /* var jsonArray: NSMutableArray? = NSMutableArray()
            
            do{
                
                jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSMutableArray
            } catch{
                
            }*/
            
            var jsonDict: NSMutableDictionary = NSMutableDictionary()
            do {
                jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSMutableDictionary
            } catch {
                
            }
            
           // let st = jsonDict.objectForKey("id")
            
            self.songLyric = NSString(string: jsonDict.objectForKey("id") as! NSString)
            //print("\(self.songLyric)")
            self.splitLyric()
            
        
    }).resume()
    }
    
    func splitLyric() {
        
        self.array = self.songLyric.componentsSeparatedByString("\n")
        self.cellCount = self.array.count
        for var i = 0; i < array.count; i++ {
            let lineString: NSString = array.objectAtIndex(i) as! NSString
            let lineArray: NSArray = lineString.componentsSeparatedByString("]")
            let a = lineArray.objectAtIndex(0) as! NSString
            //print("a-------\(a.length)")
            
            if a.length > 8 {
                let str1: NSString = lineString.substringWithRange(NSRange(location: 3, length: 1))
                let str2: NSString = lineString.substringWithRange(NSRange(location: 6, length: 1))
                //print("str1----\(str1)")
                //print("str2----\(str2)")
                
                if (str1.isEqualToString(":") && str2.isEqualToString(".")) {
                    for var i = 0; i < lineArray.count - 1; i++ {
                        let lrcStr: NSString = lineArray.objectAtIndex(lineArray.count - 1) as! NSString
                        let timeStr: NSString = self.timeToSecond(lineArray.objectAtIndex(i) as! NSString)
                        self.lrcDictionary.setValue(lrcStr, forKey: timeStr as String)
                        self.time.addObject(timeStr)
                        self.lyric.addObject(lrcStr)
                }
                }
                
                
            }
            
            //print("\(self.time[i])")
           // print("\(self.lyric[i])")
            
        }
        
        self.showlyric.hidden = false
        //self.showlyric.reloadData()
        
        //print("----------\(self.lrcDictionary)")
        
        
    }
    
    func timeToSecond(time: NSString) -> NSString {
        
        let minuts: NSString = time.substringWithRange(NSRange(location: 1, length: 2))
        let second: NSString = time.substringWithRange(NSRange(location: 4, length: 2))
        let minutsInt: NSInteger = minuts.integerValue
        let secondInt: NSInteger = second.integerValue
        
        let totalTime: NSInteger = minutsInt * 60 + secondInt
        
        let timeString: NSString = NSString(format: "%d", totalTime)
        
        return timeString
        
    }
    
    func showLyric() {
        
        let index: NSInteger = self.getNowRow()
        let path: NSIndexPath = NSIndexPath(forRow: index, inSection: 0)
        self.showlyric.scrollToRowAtIndexPath(path, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
        
        let cell: UITableViewCell = self.showlyric.cellForRowAtIndexPath(path)!
        
        for cells in self.allCell {
            
            let c: UITableViewCell = cells as! UITableViewCell
            
            c.textLabel?.textColor = UIColor.grayColor()
            c.textLabel?.font = UIFont.boldSystemFontOfSize(16)
        }
        
        cell.textLabel?.textColor = UIColor.redColor()
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        cell.textLabel?.adjustsFontSizeToFitWidth
        
        
        if self.player!.playing {
            
            let time: Double = (self.player?.currentTime)!
            
            let timeStr: NSString = self.getFomatByTime(time)
            self.beginLabel.text = timeStr as String
            self.songTimeSlider.value++
           // print("self.beginLable.text-----\(self.beginLabel.text)")
            
        }
        
        let ti: Double = (self.player?.currentTime)!
        let tv: Int = self.song.songTime.integerValue / 1000
        print("Int(self.song.songTime.doubleValue) - Int(ti) < 1\(Int(tv))-----\(Int(ti))")
        if (Int(tv) - Int(ti) < 1) {
            
            print("Int(self.song.songTime.doubleValue) - Int(ti) < 1\(Int(self.song.songTime.doubleValue))-----\(Int(ti))")
            
            self.timeColock?.invalidate()
            self.timeColock = nil
            self.beginLabel.text = self.changeTime(self.song.songTime) as String
            
        }
        
        
        
    }
    
    func getFomatByTime(time: Double) -> NSString {
        let seconds: Int = Int(time)
        let str: NSString = NSString(format: "%02d:%02d", seconds / 60, seconds % 60)
        
        //print("getFomatByTime----\(seconds)")
        
        return str
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("-----\(self.array.count)")
        return self.lyric.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell: UITableViewCell = UITableViewCell()
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        self.allCell.addObject(cell)
        cell.textLabel!.text = self.lyric[indexPath.row] as? String
        cell.textLabel?.textColor = UIColor.grayColor()
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        return cell
    }
    
    func beginPlay() {
        
        do {
            
        self.player = try AVAudioPlayer(data: datasong)
        } catch {
            
        }
        
        player?.numberOfLoops = 0
        player?.prepareToPlay()
        player?.play()
        if(timeColock == nil) {
        self.timeColock = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "showLyric", userInfo: nil, repeats: true)
        }
    }
    
    func getNowRow() -> NSInteger {
        var tem: NSInteger = 0
        for num in self.time {
            if num.doubleValue > self.player?.currentTime  {
                break
                
            }
            tem++
        }
        
        return tem - 1
    

}
    func stop() {
        if (self.player!.playing) {
            self.player?.pause()
        } else {
            self.player?.play()
        }
    }
}
