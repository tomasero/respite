//
//  HabitViewController.swift
//  breatheCnt
//
//  Created by Adam Haar Horowitz on 4/17/19.
//  Copyright © 2019 Tomás Vega. All rights reserved.
//

import UIKit

class HabitViewController: UIViewController {
  @IBOutlet weak var q1Slider: UISlider!
  @IBOutlet weak var q2Slider: UISlider!
  @IBOutlet weak var q3Slider: UISlider!
  @IBOutlet weak var q4Slider: UISlider!
  @IBOutlet weak var q5Slider: UISlider!
  @IBOutlet weak var q6Slider: UISlider!
  @IBOutlet weak var q7Slider: UISlider!
  @IBOutlet weak var q8Slider: UISlider!
  @IBOutlet weak var q9Slider: UISlider!
  @IBOutlet weak var q10Slider: UISlider!
  @IBOutlet weak var q11Slider: UISlider!
  @IBOutlet weak var q12Slider: UISlider!
  @IBOutlet weak var q1Label: UILabel!
  @IBOutlet weak var q2Label: UILabel!
  @IBOutlet weak var q3Label: UILabel!
  @IBOutlet weak var q4Label: UILabel!
  @IBOutlet weak var q5Label: UILabel!
  @IBOutlet weak var q6Label: UILabel!
  @IBOutlet weak var q7Label: UILabel!
  @IBOutlet weak var q8Label: UILabel!
  @IBOutlet weak var q9Label: UILabel!
  @IBOutlet weak var q10Label: UILabel!
  @IBOutlet weak var q11Label: UILabel!
  @IBOutlet weak var q12Label: UILabel!
  
  var q1Value: Int = 1
  var q2Value: Int = 1
  var q3Value: Int = 1
  var q4Value: Int = 1
  var q5Value: Int = 1
  var q6Value: Int = 1
  var q7Value: Int = 1
  var q8Value: Int = 1
  var q9Value: Int = 1
  var q10Value: Int = 1
  var q11Value: Int = 1
  var q12Value: Int = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSliders()
  }
  
  func setupSliders() {
    q1Slider.isContinuous = true
    q1Slider.maximumValue = 7
    q1Slider.minimumValue = 1
    q1Label.text = String(self.q1Value)
    q2Slider.isContinuous = true
    q2Slider.maximumValue = 7
    q2Slider.minimumValue = 1
    q2Label.text = String(self.q2Value)
    q3Slider.isContinuous = true
    q3Slider.maximumValue = 7
    q3Slider.minimumValue = 1
    q3Label.text = String(self.q3Value)
    q4Slider.isContinuous = true
    q4Slider.maximumValue = 7
    q4Slider.minimumValue = 1
    q4Label.text = String(self.q4Value)
    q5Slider.isContinuous = true
    q5Slider.maximumValue = 7
    q5Slider.minimumValue = 1
    q5Label.text = String(self.q5Value)
    q6Slider.isContinuous = true
    q6Slider.maximumValue = 7
    q6Slider.minimumValue = 1
    q6Label.text = String(self.q6Value)
    q7Slider.isContinuous = true
    q7Slider.maximumValue = 7
    q7Slider.minimumValue = 1
    q7Label.text = String(self.q7Value)
    q8Slider.isContinuous = true
    q8Slider.maximumValue = 7
    q8Slider.minimumValue = 1
    q8Label.text = String(self.q8Value)
    q9Slider.isContinuous = true
    q9Slider.maximumValue = 7
    q9Slider.minimumValue = 1
    q9Label.text = String(self.q9Value)
    q10Slider.isContinuous = true
    q10Slider.maximumValue = 7
    q10Slider.minimumValue = 1
    q10Label.text = String(self.q10Value)
    q11Slider.isContinuous = true
    q11Slider.maximumValue = 7
    q11Slider.minimumValue = 1
    q11Label.text = String(self.q11Value)
    q12Slider.isContinuous = true
    q12Slider.maximumValue = 7
    q12Slider.minimumValue = 1
    q12Label.text = String(self.q12Value)
  }
  
  @IBAction func q1Updated(_ sender: UISlider) {
    q1Value = Int(sender.value)
    q1Slider.value = Float(self.q1Value)
    q1Label.text = String(q1Value)
  }
  
  @IBAction func q2Updated(_ sender: UISlider) {
    q2Value = Int(sender.value)
    q2Slider.value = Float(self.q2Value)
    q2Label.text = String(q2Value)
  }
  @IBAction func q3Updated(_ sender: UISlider) {
    q3Value = Int(sender.value)
    q3Slider.value = Float(self.q3Value)
    q3Label.text = String(q3Value)
  }
  @IBAction func q4Updated(_ sender: UISlider) {
    q4Value = Int(sender.value)
    q4Slider.value = Float(self.q4Value)
    q4Label.text = String(q4Value)
  }
  @IBAction func q5Updated(_ sender: UISlider) {
    q5Value = Int(sender.value)
    q5Slider.value = Float(self.q5Value)
    q5Label.text = String(q5Value)
  }
  @IBAction func q6Updated(_ sender: UISlider) {
    q6Value = Int(sender.value)
    q6Slider.value = Float(self.q6Value)
    q6Label.text = String(q6Value)
  }
  @IBAction func q7Updated(_ sender: UISlider) {
    q7Value = Int(sender.value)
    q7Slider.value = Float(self.q7Value)
    q7Label.text = String(q7Value)
  }
  @IBAction func q8Updated(_ sender: UISlider) {
    q8Value = Int(sender.value)
    q8Slider.value = Float(self.q8Value)
    q8Label.text = String(q8Value)
  }
  @IBAction func q9Updated(_ sender: UISlider) {
    q9Value = Int(sender.value)
    q9Slider.value = Float(self.q9Value)
    q9Label.text = String(q9Value)
  }
  @IBAction func q10Updated(_ sender: UISlider) {
    q10Value = Int(sender.value)
    q10Slider.value = Float(self.q10Value)
    q10Label.text = String(q10Value)
  }
  @IBAction func q11Updated(_ sender: UISlider) {
    q11Value = Int(sender.value)
    q11Slider.value = Float(self.q11Value)
    q11Label.text = String(q11Value)
  }
  @IBAction func q12Updated(_ sender: UISlider) {
    q12Value = Int(sender.value)
    q12Slider.value = Float(self.q12Value)
    q12Label.text = String(q12Value)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
