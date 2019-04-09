//
//  InterfaceController.swift
//  ynabWatchOS Extension
//
//  Created by Jacob Pyke on 09.04.19.
//  Copyright © 2019 pykeeco. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var slider: WKInterfaceSlider!
    @IBOutlet weak var valueLabel: WKInterfaceLabel!
    var totalValue: Double = 0.0
    var lastSliderValue: Float = 0.0
    
    @IBAction func sliderAdjusted(_ value: Float) {
        if lastSliderValue < value {
            totalValue += Double(value)
        } else {
            totalValue -= Double(value)
        }
        lastSliderValue = value
        
        setLabelValue()
    }
    @IBAction func foodPressed() {
        
    }
    
    var crownAccumulator = 0.0
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        crownSequencer.delegate = self as WKCrownDelegate
        // Configure interface objects here.
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        crownAccumulator += rotationalDelta
        print(rotationalDelta)
        if rotationalDelta > 0.1 && rotationalDelta < 1 {
            totalValue += 10
            setSliderValue()
            setLabelValue()
            crownAccumulator = 0.0
        } else if rotationalDelta > 1 && rotationalDelta < 10 {
            totalValue += 100
            setSliderValue()
            setLabelValue()
            crownAccumulator = 0.0
        } else if rotationalDelta > 10 {
            totalValue += 1000
            setLabelValue()
            crownAccumulator = 0.0
        } else if rotationalDelta < -0.1 && rotationalDelta > -1 {
            totalValue -= 10
            setSliderValue()
            setLabelValue()
            crownAccumulator = 0.0
        } else if rotationalDelta < -1 && rotationalDelta > -10 {
            totalValue -= 100
            setSliderValue()
            setLabelValue()
            crownAccumulator = 0.0
        } else if rotationalDelta < -10 {
            totalValue -= 1000
            setSliderValue()
            setLabelValue()
            crownAccumulator = 0.0
        }
        
    }
    func setSliderValue() {
        slider.setValue(Float(totalValue))
    }
    
    func setLabelValue() {
        valueLabel.setText("€" + String(totalValue / 1000))
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        crownSequencer.focus()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}

extension InterfaceController: WKCrownDelegate {
}
