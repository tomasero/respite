//
//  Signal.swift
//  breatheCnt
//
//  Created by Tomás Vega on 4/21/19.
//  Copyright © 2019 Tomás Vega. All rights reserved.
//

import Foundation

class Signal {
    static func getBreaths(data: [Double], maxJump: Double, cutoff: Double, freq: Double, intervalLength: Int, thresh: Double, windowSize: Int, factor: Double, minSize: Int) -> [Int: Int] {
        let clean = cleanDataFromJumps(data: data, maxJump: maxJump)
        let filtered = lowPassFilter(data: clean, cutoff: cutoff, freq: freq)
        let follower = getEnvelope(inputSignal: filtered, intervalLength: intervalLength)
        let filtFollower = lowPassFilter(data: follower, cutoff: cutoff, freq: freq)
        let peaksDetector = peakDetector(dataset: filtFollower, thresh: thresh, windowSize: windowSize, factor: factor)
        let peakCount = peakCounter(peaks: peaksDetector, minSize: minSize)
        return peakCount
    }
    
    static func cleanDataFromJumps(data: [Double], maxJump: Double) -> [Double] {
        var cleaned: [Double] = []
        var prev = 0.0
        var clean = 0.0
        for datum in data {
            if (abs(datum) > maxJump) || (abs(datum - prev) > maxJump*4/5) {
                clean = prev
            } else {
                clean = datum
                prev = datum
            }
            cleaned.append(clean)
        }
        return cleaned
    }
    
    static func lowPassFilter(data: [Double], cutoff: Double, freq: Double) -> [Double] {
        let dt = 1/freq
        let RC = 1/(2 * Double.pi * cutoff)
        let alpha = dt / (RC + dt)
        var smoothed: [Double] = []
        var prev = 0.0
        for sample in data {
            let smooth = alpha*sample + (1 - alpha)*prev
            smoothed.append(smooth)
            prev = smooth
        }
        return smoothed
    }
    
    static func getEnvelope(inputSignal: [Double], intervalLength: Int) -> [Double] {
        var absoluteSignal: [Double] = []
        for var sample in inputSignal {
            if sample < 0 {
                sample = 0
            }
            absoluteSignal.append(abs(sample)) //abs unnecessary
        }
        
        var outputSignal: [Double] = []
        for baseIndex in intervalLength...absoluteSignal.count-1 {
            var maximum = 0.0
            for lookbackIndex in 0...intervalLength-1 {
                maximum = max (absoluteSignal [baseIndex - lookbackIndex], maximum)
            }
            outputSignal.append(maximum)
        }
        return outputSignal
    }
    
    static func peakDetector(dataset: [Double], thresh: Double, windowSize: Int, factor: Double) -> [Int] {
        var state: Int = 0
        var peaks: [Int] = []
        var prev: Double = 0.0
        var window: [Double] = Array(repeating: 0.0, count: windowSize)
        for sample in dataset {
            window.append(sample)
            window.removeFirst()
            prev  = 0.0
            var pos = 0
            var neg = 0
            for wSample in window {
                let delta = wSample - prev
                if delta > thresh {
                    pos += 1
                } else if delta < thresh * -1 {
                    neg += 1
                }
                prev = wSample
            }
            if pos > Int(Double(windowSize) * factor) {
                state = 1
            } else if neg > Int(Double(windowSize) * factor) {
                state = -1
            }
            peaks.append(state)
        }
        return peaks
    }
    
    static func peakCounter(peaks: [Int], minSize: Int) -> [Int: Int] {
        var prev = 0
        var prevCount = 0
        var peakCount: [Int: Int] = [1: 0, -1: 0, 0: 0]
        for peak in peaks {
            if peak == prev {
                prevCount += 1
                if prevCount == minSize {
                    peakCount[peak]! += 1
                }
            } else {
                prevCount = 1
            }
            prev = peak
        }
        return peakCount
    }
}
