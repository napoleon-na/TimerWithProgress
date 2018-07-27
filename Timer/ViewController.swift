//
//  ViewController.swift
//  Timer
//
//  Created by Naomi Watanabe on 2018/07/27.
//  Copyright © 2018年 N Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer : Timer!
    var count : Float!
    var pauseTime:Float = 0
    let limit : Float = 10.0
    var timeInterval : Float = 0.01
    var progressUnit : Float!
    var state = State.start
    
    enum State {
        case start
        case running
        case pause
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = limit
        progressUnit = timeInterval / limit
        timeLabel.text = String(format: "%.2f", limit)
    }
    
    @IBAction func onReset(_ sender: Any) {
        reset()
    }
    
    @IBAction func onStart(_ sender: Any) {
        switch state {
        case .start, .pause:
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(self.onUpdate(timer:)), userInfo: nil, repeats: true)
            actionButton.setTitle("Stop", for: .normal)
            state = .running
        
        case .running:
            timer.invalidate()
            actionButton.setTitle("Resume", for: .normal)
            state = .pause
        }
    }
    
    @objc func onUpdate(timer : Timer){
        count = count - timeInterval
        timeLabel.text = String(format: "%.2f", count)
        progressView.setProgress(progressView.progress + progressUnit, animated: true)
        
        if count <= 0 {
            reset()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reset() {
        timer.invalidate()
        actionButton.setTitle("Start", for: .normal)
        state = .start
        timeLabel.text = String(format: "%.2f", limit)
        count = limit
        progressView.setProgress(0, animated: false)
    }
}
