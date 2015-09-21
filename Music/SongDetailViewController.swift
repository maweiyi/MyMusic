//
//  SongDetailViewController.swift
//  Music
//
//  Created by 麻炜怡 on 9/16/15.
//  Copyright © 2015 CodeMonkey. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

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
    
    @IBAction func playActionBtn(sender: AnyObject) {
    }
    
    @IBAction func nextSongAction(sender: AnyObject) {
    }
    
    var song: SongDetailList = SongDetailList()
    //歌词字符串
    var songLyric: NSString = NSString()
    
    var lrcDictionary: NSMutableDictionary = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //今天不想写
        print("\(self.song.songString)")
        
        self.getLyric()
        
    
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
        
        let array: NSArray = self.songLyric.componentsSeparatedByString("\n")
        for var i = 0; i < array.count; i++ {
            let lineString: NSString = array.objectAtIndex(i) as! NSString
            let lineArray: NSArray = lineString.componentsSeparatedByString("]")
            let a = lineArray.objectAtIndex(0) as! NSString
            print("a-------\(a.length)")
            
            if a.length > 8 {
                let str1: NSString = lineString.substringWithRange(NSRange(location: 3, length: 1))
                let str2: NSString = lineString.substringWithRange(NSRange(location: 6, length: 1))
                print("str1----\(str1)")
                print("str2----\(str2)")
                
                if (str1.isEqualToString(":") && str2.isEqualToString(".")) {
                    for var i = 0; i < lineArray.count - 1; i++ {
                        let lrcStr: NSString = lineArray.objectAtIndex(lineArray.count - 1) as! NSString
                        let timeStr: NSString = self.timeToSecond(lineArray.objectAtIndex(i) as! NSString)
                        self.lrcDictionary.setValue(lrcStr, forKey: timeStr as String)
                     print("hello World-------")
                    }
                }
                
                
            }
            
            
            
        }
        
        print("----------\(self.lrcDictionary)")
        
        
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

}
