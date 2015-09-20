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
            
            print("\(jsonDict)")
            
            
        
    }).resume()
    }

}
