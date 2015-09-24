//
//  SongTableViewController.swift
//  Music
//
//  Created by 麻炜怡 on 9/15/15.
//  Copyright © 2015 CodeMonkey. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    var songIdArray: NSMutableArray? = nil //创建一个数组用来存储歌单中歌曲的ID
    var tablesIndex: Int = 0
    var songArray: SongDetailList = SongDetailList()
    
     //生成一个单例
    /*class var songShareInstace: SongTableViewController {
        struct SingleTon {
            static let instance = SongTableViewController()
        }
        return SingleTon.instance
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.tableView.hidden = true
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       // print("tableIndex-------\(self.tablesIndex)")
        //print("songIdArray------\(self.songIdArray)")
        let dictionary: NSDictionary = NSDictionary(object: (songIdArray?.objectAtIndex(tablesIndex))!, forKey: "id")
        var jsonData: NSData = NSData()
        
        do {
            
            jsonData = try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
        } catch {
            
        }
        
        let stringUrl: NSString = NSString(string: "http://127.0.0.1:8000/music/hello/")
        let url: NSURL = NSURL(string: stringUrl as String)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = jsonData
        
        let session: NSURLSession = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            var jsonArray: NSMutableArray? = NSMutableArray()
            
            do{
                
                jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSMutableArray
            } catch{
                
            }
            //print("\(jsonArray)")
            self.songArray.songIDS.addObjectsFromArray((jsonArray?.objectAtIndex(0))! as! [AnyObject])
            self.songArray.songNames.addObjectsFromArray((jsonArray?.objectAtIndex(1))! as! [AnyObject])
            self.songArray.songTimes.addObjectsFromArray((jsonArray?.objectAtIndex(2))! as! [AnyObject])
            self.songArray.songMp3Url.addObjectsFromArray((jsonArray?.objectAtIndex(3))! as! [AnyObject])
            self.tableView.hidden = false
            self.tableView.reloadData()
            self.tableView.setNeedsDisplay()
            
            //print("songIDS----\(self.songArray.songIDS)")
            //print("songNames-----\(self.songArray.songNames.count)")
            //print("songTimes-----\(self.songArray.songTimes.count)")
            //print("songMp3Url-----\(self.songArray.songMp3Url.count)")
        }).resume()
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.songArray.songNames.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        
       cell.textLabel?.text = self.songArray.songNames[indexPath.row] as? String
       cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let songDetail: SongDetailViewController = storyboard.instantiateViewControllerWithIdentifier("Song") as! SongDetailViewController
        songDetail.song.songString = NSString(format: "%d", (self.songArray.songIDS.objectAtIndex(indexPath.row).integerValue)!)
        songDetail.song.songMp3 = self.songArray.songMp3Url.objectAtIndex(indexPath.row) as! NSString
        songDetail.song.songTime = NSString(format: "%d", (self.songArray.songTimes.objectAtIndex(indexPath.row).integerValue)!);
        
        self.navigationController?.pushViewController(songDetail, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   
    
    

}
