//
//  ViewController.swift
//  CatchTheKennyOdev
//
//  Created by Kamil Basmaz on 27.11.2017.
//  Copyright © 2017 Kamil Basmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewKenny: UIImageView!
    @IBOutlet weak var labelKoordinat: UILabel!
    @IBOutlet weak var labelHighScore: UILabel!
    @IBOutlet weak var labelClickCount: UILabel!
    var highScoreStored  = 0
    var timer = Timer()
    var ClickCount = 0
    var time =  0
    var highScore = 0
    var timex  = 30
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // high skora bak  var mı
        
        let hs =  UserDefaults.standard.object(forKey: "HighScoreForKennyApplication")
        if let nx = hs  as? Int {
            labelHighScore.text = "High Score : \(nx)"
            highScoreStored = nx
        }else{
            labelHighScore.text = "High Score : 0 "
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(timerFunction), userInfo: false, repeats: true)
        
        viewKenny.isUserInteractionEnabled = true
        let gesRecog = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
        viewKenny.addGestureRecognizer(gesRecog)
 
   

    }

    @objc func timerFunction(){
        timex = timex - 1
        labelKoordinat.text = "Time :  \(timex)"
        
        if timex <= 0 {
            timer.invalidate()
            viewKenny.isUserInteractionEnabled  = false
            
            if ClickCount > highScoreStored
            {
                UserDefaults.standard.set(ClickCount, forKey: "HighScoreForKennyApplication")
                UserDefaults.standard.synchronize()
                self.labelHighScore.text = "High Score : \(self.ClickCount)"
            }
            
            let alertx = UIAlertController (title: "Oyun Bitti", message: "Süre Doldu", preferredStyle: UIAlertControllerStyle.alert)
            
            let ButtonOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            alertx.addAction(ButtonOK)
            
            let buttonReplay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.ClickCount = 0
                self.viewKenny.isUserInteractionEnabled = true
                self.timex = 30
                self.labelKoordinat.text = "Time :  \(self.timex)"
                self.labelClickCount.text = "Skor : \(self.ClickCount)"
                self.timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(ViewController.timerFunction), userInfo: false, repeats: true)
                
            })
            alertx.addAction(buttonReplay)
           self.present(alertx, animated: true, completion: nil)
            
            
            
        } else
        {
            changeImagelocation()
        }
    }

    @objc func viewClicked(){
        
        ClickCount = ClickCount + 1
        labelClickCount.text = "Skor : \(ClickCount)"
    }
    func changeImagelocation(){
        
        var frame = CGRect()
        frame  =  viewKenny.frame
        let random = arc4random_uniform(6)
        if random == 0 {
            frame.origin.x = 100
            frame.origin.y = 100
            
            
        } else if random == 1 {
            frame.origin.x = 200
            frame.origin.y = 300
            
        }else if random == 2 {
            frame.origin.x = 80
            frame.origin.y = 200
            
        }else if random == 3 {
            frame.origin.x = 30
            frame.origin.y = 400
            
        }else if random == 4 {
            frame.origin.x = 150
            frame.origin.y = 250
            
        }else {
            frame.origin.x = 210
            frame.origin.y = 600
        }
 
        
        viewKenny.frame = frame
    
}
    }


