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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //今天不想写
    
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

}
