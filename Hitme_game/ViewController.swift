//
//  ViewController.swift
//  Hitme_game
//
//  Created by Sherlock.Yu on 14-12-26.
//  Copyright (c) 2014年 Sherlock.Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue : Int = 0
    var targetValue : Int = 0
    var score : Int = 0
    var round : Int = 1

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startNewGame()   //ViewController is the receiver receiver.methodName(参数)
        updateLabels()
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func showAlert(){
        let difference : Int = abs(targetValue - currentValue)
        var points : Int = 100 - difference
        
        var title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1   {
            points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
            
        } else{
            title = "Not even close!"
        }
        score += points
        
        scoreLabel.text = String(score)
        round += 1
        roundLabel.text = String(round)
        let message  = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" + "\nYour scored \(points) points"
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler:{
            action in
            self.startNewRound()
            self.updateLabels()     //利用event进行函数回调，直接调用 handler中的方法
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        self.startNewRound()
        updateLabels()
        
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        println("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
        
        
    }
    
    @IBAction func startOver(){
        startNewGame()
        updateLabels()
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

