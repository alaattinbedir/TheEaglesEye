//
//  ViewController.swift
//  EaglesEye
//
//  Created by Alaattin Bedir on 10/29/16.
//  Copyright © 2016 Magic Lump Games. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    var timer:Timer!
    
    @IBOutlet weak var mainSlider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var avgScoreLabel: UILabel!
    @IBOutlet weak var totRoundLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setScreeName(name: "Game Screen")
        sendScreenView()
        
//        let name = "Game Screen"
//        let tracker = GAI.sharedInstance().defaultTracker
//        tracker?.set(kGAIScreenName, value: name)
//        let build = (GAIDictionaryBuilder.createScreenView().build() as NSDictionary) as! [AnyHashable: Any]
//        tracker?.send(build)
        
        HZIncentivizedAd.fetch()
        HZInterstitialAd.fetch()
        
        let options = HZBannerAdOptions()
        options.presentingViewController = self // Only necessary if you're using multiple view controllers in your app
        
        HZBannerAdController.sharedInstance().placeBanner(at: HZBannerPosition.bottom, options:options,
                                                          success:
            {
                (banner) in
            }, failure: {
                (error) in print("Error is \(error)")
            }
        )
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        mainSlider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        mainSlider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        mainSlider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        mainSlider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
        updateLabels()
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(){
        
        if(round%10 == 0){
            // InterstitialAds are automatically fetched from our server
            let options = HZShowOptions()
            options.viewController = self // Only necessary if you're using multiple view controllers in your app
            HZInterstitialAd.show(with: options)
            HZInterstitialAd.fetch()
            
        }
        
        timer.invalidate()
        if currentValue > 100 {
            currentValue = 200-currentValue
        }
        
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        
        let message = "You scored \(points) points"
        
        let title: String
        if difference == 0 {
            title = "\(currentValue) \n Perfect!"
        } else if difference < 5 {
            title = "\(currentValue) \n You almost had it!"
        } else if difference < 10 {
            title = "\(currentValue) \n Pretty good!"
        } else {
            title = "\(currentValue) \n Not even close..."
        }
        
        score += points
        
        let alert = UIAlertController(title:title,
                                      message:message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title:"OK", style: .default,
                                   handler:{ action in
                                    self.startNewRound()
                                    self.updateLabels()
        })
        alert.addAction(action)
        
        present(alert,animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func startOver() {
        
        timer.invalidate()
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
        
        // InterstitialAds are automatically fetched from our server
        let options = HZShowOptions()
        options.viewController = self // Only necessary if you're using multiple view controllers in your app
        HZIncentivizedAd.show(with: options)
        HZIncentivizedAd.fetch()
        
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.0055,
                                     repeats: true,
                                     block: {(timer) in
                                        self.mainSlider.value = Float(self.currentValue)
                                        if self.currentValue >= 0 && self.currentValue < 100 {
                                            self.currentValue = self.currentValue+1
                                            self.mainSlider.value = Float(self.currentValue)
                                        }
                                        if self.currentValue >= 100 {
                                            self.currentValue = self.currentValue+1
                                            self.mainSlider.value = Float(200-self.currentValue)
                                            if self.currentValue == 200{
                                                self.currentValue=0
                                            }
                                        }
                                        
        })

    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round%10)
        totRoundLabel.text = String(round)
        let avgResult = score/round;
        avgScoreLabel.text = String(lroundf(Float(avgResult)))
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    

}

