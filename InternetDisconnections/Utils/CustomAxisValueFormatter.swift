//
//  CustomAxisValueFormatter.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 03/11/2022.
//

import Foundation
import Charts
public class CustomAxisValueFormatter: AxisValueFormatter {
var labels: [String] = []
public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let count = self.labels.count
    guard let axis = axis, count > 0 else {
        return ""
    }
    let factor = axis.axisMaximum / Double(count)
    let index = Int((value / factor).rounded())
    if index >= 0 && index < count {
        return self.labels[index]
    }
    return ""
}
 }
