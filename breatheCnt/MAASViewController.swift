//
//  MAASViewController.swift
//  breatheCnt
//
//  Created by Adam Haar Horowitz on 4/17/19.
//  Copyright © 2019 Tomás Vega. All rights reserved.
//

import UIKit

class MAASViewController: UIViewController {
  @IBOutlet weak var q1Slider: UISlider!
  @IBOutlet weak var q2Slider: UISlider!
  @IBOutlet weak var q3Slider: UISlider!
  @IBOutlet weak var q4Slider: UISlider!
  @IBOutlet weak var q5Slider: UISlider!
  @IBOutlet weak var q1Label: UILabel!
  @IBOutlet weak var q2Label: UILabel!
  @IBOutlet weak var q3Label: UILabel!
  @IBOutlet weak var q4Label: UILabel!
  @IBOutlet weak var q5Label: UILabel!
  
  var q1Value: Int = 1
  var q2Value: Int = 1
  var q3Value: Int = 1
  var q4Value: Int = 1
  var q5Value: Int = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSliders()
  }
  
  func setupSliders() {
    q1Slider.isContinuous = true
    q1Slider.maximumValue = 6
    q1Slider.minimumValue = 1
    q1Label.text = String(self.q1Value)
    q2Slider.isContinuous = true
    q2Slider.maximumValue = 6
    q2Slider.minimumValue = 1
    q2Label.text = String(self.q2Value)
    q3Slider.isContinuous = true
    q3Slider.maximumValue = 6
    q3Slider.minimumValue = 1
    q3Label.text = String(self.q3Value)
    q4Slider.isContinuous = true
    q4Slider.maximumValue = 6
    q4Slider.minimumValue = 1
    q4Label.text = String(self.q4Value)
    q5Slider.isContinuous = true
    q5Slider.maximumValue = 6
    q5Slider.minimumValue = 1
    q5Label.text = String(self.q5Value)
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
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
