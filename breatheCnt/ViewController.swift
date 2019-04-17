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
    var timer: Timer!
    @IBOutlet weak var rawXLabel: UILabel!
    @IBOutlet weak var rawYLabel: UILabel!
    @IBOutlet weak var rawZLabel: UILabel!
    @IBOutlet weak var rawBLabel: UILabel!
    @IBOutlet weak var usrXLabel: UILabel!
    @IBOutlet weak var usrYLabel: UILabel!
    @IBOutlet weak var usrZLabel: UILabel!
    @IBOutlet weak var usrBLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
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
        // Do any additional setup after loading the view.
//        motionManager.startAccelerometerUpdates()
//        motionManager.startGyroUpdates()
//        motionManager.startMagnetometerUpdates()
//        motionManager.startDeviceMotionUpdates()
//        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: Selector(update), userInfo: nil, repeats: true)
        setupAcc(interval: 0.1)
        setupMotion(interval: 0.1)
//        setupAltimeter(interval: 0.1)

//        motionManager.accelerometerUpdateInterval = 1.0
//        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
//            if let myData = data{
//                print(myData)
//            }
//        }
//        motionManager.deviceMotionUpdateInterval = 1.0
//        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
//            if let myData = data{
//                print(myData)
//            }
//        }
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
    func setupMotion(interval: Double) {
        motionManager.deviceMotionUpdateInterval = interval
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            if let acc = data?.userAcceleration {
                let x = acc.x * 1000
                let y = acc.y * 1000
                var z = (acc.z * 1000) + self.bias
                self.norm = Double((x*x + y*y + z*z).squareRoot())
//                print(data)
//
//                print("x:" + String(x))
//                print("y:" + String(y))
                print("z:" + String(z))
                print("p:" + String(self.usrZ))
//                print("s:" + String(norm))
                if abs(z) > self.maxJump {
//                    print(self.maxJump)
                    z = self.usrZ
//                    return
                }
                self.usrX = x * self.alpha + self.usrXAvg * (1 - self.alpha)
                self.usrY = y * self.alpha + self.usrYAvg * (1 - self.alpha)
                self.usrZ = z * self.alpha + self.usrZAvg * (1 - self.alpha)
//                print(self.usrZ)
//                print("---")
                self.usrXLabel.text = self.toString(double: self.usrX)
                self.usrYLabel.text = self.toString(double: self.usrY)
                self.usrZLabel.text = self.toString(double: self.usrZ)
                let rawS = String(format: "%.3f, %.3f, %.3f", x, y, z)
                let usrS = String(format: "%.3f, %.3f, %.3f", self.usrX, self.usrY, self.usrZ)
//                print(rawS)
//                print(usrS)
//                print("---------------")
                self.usrXAvg = self.usrX
                self.usrYAvg = self.usrY
                self.usrZAvg = self.usrZ
                self.processData()
            }
        }
    }
    let thresh = 1.8
    var count = 0
    func processData() {
        self.window.removeFirst()
//        self.window.append(self.usrZ)
        self.window.append(self.usrZ)
//        print(self.usrZ)
        var pos = 0
        var neg = 0
        var inc = 0
        var dec = 0
//        var prevSample = 0.0
        for sample in window {
            if sample > thresh {
                pos += 1
            } else if sample < (-1 * thresh*1.0) {
                neg += 1
            }
//            if sample - prevSample > 0 {
//                inc += 1
//            } else if sample - prevSample < 0 {
//                dec += 1
//            }
//            prevSample = sample
        }
        
//        print(pos, neg)
//        print(inc, dec)
//        print("--------")
        if pos > windowSize*5/9 {
//            print("Breathing in")
            print("b:1")
            resetWindow()
        } else if neg > windowSize*5/9 {
//            print("Breathing out")
            resetWindow()
            print("b:-1")
        }
        print("p:" + String(pos))
        print("n:" + String(neg))
//        print("b:" + String(neg))
    }
    
    func resetWindow() {
        self.window = Array(repeating: 0.0, count: 15)
//        self.usrZAvg = 0.0
    }
    
    func toString(double: Double) -> String {
        return String(format: "%.5f", double)
    }
    
    @IBAction func reset(_ sender: Any) {
        
    }
    
//    func update() {
//        if let accelerometerData = motionManager.accelerometerData {
//            print("accelerometer")
//            print(accelerometerData)
//        }
//        if let gyroData = motionManager.gyroData {
//            print("gyro")
//            print(gyroData)
//        }
//        if let magnetometerData = motionManager.magnetometerData {
//            print("mag")
//            print(magnetometerData)
//        }
//        if let deviceMotion = motionManager.deviceMotion {
//            print("motion")
//            print(deviceMotion)
//        }
//    }


}

