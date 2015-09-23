//
//  ViewController.swift
//  Music
//
//  Created by 麻炜怡 on 9/15/15.
//  Copyright © 2015 CodeMonkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewAppr:UIView = UIView()
    var topPlayLists: TopPlayLists = TopPlayLists()


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.

        /*self.viewAppr.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20);
        self.viewAppr.backgroundColor = UIColor(red: 233/255, green: 142/255, blue: 158/255, alpha: 1)
        self.view.addSubview(self.viewAppr)*/
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(TableCell.classForCoder(), forCellReuseIdentifier: "Cell")
        //从服务端请求数据
        self.tableView.hidden = true
        print("Hello World1")
        //self.navigationController?.navigationBar.
        self.getDataFromServer()
        
}


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.topPlayLists.listId.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        //var layer: CALayer
       /* let stringUrl: NSString = NSString(string: self.topPlayLists.listImage[indexPath.row] as! String)
        let url: NSURL = NSURL(string: stringUrl as String)!
        print("\(url)")
        var data: NSData = NSData(contentsOfURL: url)!
        
        cell.imageView?.image = UIImage(data: data)*/
        cell.imageView?.image = UIImage(named: "headerImage")
        cell.imageView?.layer.cornerRadius = 30
        cell.imageView?.clipsToBounds = true
        
        cell.textLabel?.text = self.topPlayLists.listName[indexPath.row] as! String
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell as UITableViewCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let songTableView: SongTableViewController = SongTableViewController()
        songTableView.songIdArray = topPlayLists.listId
        songTableView.tablesIndex = indexPath.row
        //songTableView.viewDidLoad()
        self.navigationController?.pushViewController(songTableView, animated: true)
        
    }
    //从服务端获取数据
    func getDataFromServer() {
        
        print("Hello World2")
        
        let stringUrl: NSString = NSString(string: "http://127.0.0.1:8000/music/hello1/")
        let url: NSURL = NSURL(string: stringUrl as String)!
        
        let session: NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithURL(url, completionHandler: {
            (data, response, error) -> Void in
            
            // var jsonArray: NSMutableArray = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSMutableArray
            
            var jsonArray: NSMutableArray? = NSMutableArray()
                
            do{
                
                jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSMutableArray
            } catch{
                
            }
            self.topPlayLists.listId.addObjectsFromArray((jsonArray?.objectAtIndex(0))! as! [AnyObject])
            self.topPlayLists.listName.addObjectsFromArray(jsonArray?.objectAtIndex(1) as! [AnyObject])
            self.topPlayLists.listImage.addObjectsFromArray(jsonArray?.objectAtIndex(2) as! [AnyObject])
           /* print("\(self.topPlayLists.listId.count)")
            
            print("\(self.topPlayLists.listId)")
            print("\(self.topPlayLists.listImage)")
            print("\(self.topPlayLists.listName)")

           */
            
            self.tableView.hidden = false
            self.tableView.reloadData()
            
            self.tableView.setNeedsDisplay()
                
                
            
            
        }).resume()
        
        
}
}

