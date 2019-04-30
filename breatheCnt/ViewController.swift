//
//  ViewController.swift
//  breatheCnt
//
//  Created by Tomás Vega on 4/13/19.
//  Copyright © 2019 Tomás Vega. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    let altimeter = CMAltimeter()
    var timer = Timer()
    @IBOutlet weak var rawXLabel: UILabel!
    @IBOutlet weak var rawYLabel: UILabel!
    @IBOutlet weak var rawZLabel: UILabel!
    @IBOutlet weak var rawBLabel: UILabel!
    @IBOutlet weak var usrXLabel: UILabel!
    @IBOutlet weak var usrYLabel: UILabel!
    @IBOutlet weak var usrZLabel: UILabel!
    @IBOutlet weak var usrBLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var breathsLabel: UILabel!
    @IBOutlet weak var timeStepper: UIStepper!
    
    var rawX: Double = 0
    var rawY: Double = 0
    var rawZ: Double = 0
    var usrX: Double = 0
    var usrY: Double = 0
    var usrZ: Double = 0

    var rawXAvg: Double = 0
    var rawYAvg: Double = 0
    var rawZAvg: Double = 0
    var usrXAvg: Double = 0
    var usrYAvg: Double = 0
    var usrZAvg: Double = 0
    
    var rawB: Int = 0
    var usrB: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeStepper.wraps = true
        timeStepper.autorepeat = true
        timeStepper.maximumValue = 5
        timeStepper.minimumValue = 1
        timeStepper.value = 1
    }
//    var pressure:Float = 0.00
//    var pressureInHg:Float = 0.00
    var altitude:Float = 0.00
    func setupAltimeter(interval: Double) {
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            self.altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { (altitudeData:CMAltitudeData?, error:Error?) in
//                print(altitudeData)
                if (error != nil) {

                    self.stopAltimeter()
                    
                } else {
//                    self.pressure = altitudeData!.pressure.floatValue
//                    self.pressureInHg = self.pressure * 0.2953
                    self.altitude = Float(altitudeData!.relativeAltitude.floatValue)
                    print(self.altitude)
                }
            })
        } else {
            print("No altimeter on this device")
        }
    }
    
    
    
    func stopAltimeter() {
        print("stopAltimeter Func")
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            altimeter.stopRelativeAltitudeUpdates() // Stop updates
            print("Stopped relative altitude updates.")
        }
    }
    func setupAcc(interval: Double) {
        motionManager.accelerometerUpdateInterval = interval
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let acc = data?.acceleration {
                self.rawX = acc.x * self.alpha + self.rawXAvg * (1 - self.alpha)
                self.rawY = acc.y * self.alpha + self.rawYAvg * (1 - self.alpha)
                self.rawZ = acc.z * self.alpha + self.rawZAvg * (1 - self.alpha)
                self.rawXAvg = self.rawX
                self.rawYAvg = self.rawY
                self.rawZAvg = self.rawZ
                self.rawXLabel.text = self.toString(double: self.rawX)
                self.rawYLabel.text = self.toString(double: self.rawY)
                self.rawZLabel.text = self.toString(double: self.rawZ)
//                let rawS = String(format: "%.3f, %.3f, %.3f", self.rawX, self.rawY, self.rawZ)
//                print(rawS)
//                let usrS = String(format: "%.3f, %.3f, %.3f", self.usrX, self.usrY, self.usrZ)
//                print(usrS)
//                print("---------------")
            }
        }
    }
    
    
    
    let alpha = 0.1
    let windowSize:Int = 15
    let bias = 1.5
    var window:[Double] = Array(repeating: 0.0, count: 15)
    let maxJump = 25.0
    var norm = 0.0
    var sessionData: [Double] = []
    func setupMotion(interval: Double) {
        self.sessionData = []
        motionManager.deviceMotionUpdateInterval = interval
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            if let acc = data?.userAcceleration {
                self.usrX = (acc.x * 1000)
                self.usrY = (acc.y * 1000)
                self.usrZ = (acc.z * 1000) + self.bias
                self.sessionData.append(self.usrZ)
                self.usrXLabel.text = String(format: "%.2f", self.usrX)
                self.usrYLabel.text = String(format: "%.2f", self.usrY)
                self.usrZLabel.text = String(format: "%.2f", self.usrZ)
            }
        }
    }
    
    func stopMotion() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func toString(double: Double) -> String {
        return String(format: "%.5f", double)
    }
    
    @IBAction func reset(_ sender: Any) {
        
    }
    
    func startTimer(time: Double) {
        print("startTimer")
        print(String(time*60))
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: time*60, target: self, selector: #selector(endSession), userInfo: nil, repeats: false)
    }

    var sessionLength: Int = 1
    @IBAction func lengthChanged(_ sender: UIStepper) {
        print(sessionLength)
        sessionLength = Int(sender.value)
    }
    
    var breathing: Bool = false
    @IBAction func startAndStop(_ sender: UIButton) {
        if !breathing {
            print("not breathing")
            setupMotion(interval: 0.01)
            breathing = true
            sender.setTitle("Stop", for: .normal)
            startTimer(time: Double(sessionLength))
        } else {
            print("breathing")
            endSession()
        }
    }
    
    @objc func endSession() {
        print("stopTimer")
        timer.invalidate()
        stopMotion()
        breathing = false
        startButton.setTitle("Start", for: .normal)
        processData()
    }
    
    func processData() {
        let maxJump = 20.0
        let cutoff = 0.25
        let freq = 100.0
        let thresh = 0.005
        let windowSize = 50
        let factorOfWindowSize: Double = 5/9
        let minSize = 30
        
        if sessionData.count < windowSize {
            breathsLabel.text = String("Session too short")
            return
        }
        
        let breaths = Signal.getBreaths(data: sessionData, maxJump: maxJump, cutoff: cutoff, freq: freq, intervalLength: windowSize, thresh: thresh, windowSize: windowSize, factor: factorOfWindowSize, minSize: minSize)
        breathsLabel.text = String(breaths[1]!)
    }
}
