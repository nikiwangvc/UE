//  Created by Jeffrey Kozik on 12/3/21.

import Foundation
import Charts

// https://stackoverflow.com/questions/41720445/ios-charts-3-0-align-x-labels-dates-with-plots
class ChartXAxisFormatter: NSObject {
    var dateFormatter: DateFormatter?
}

extension ChartXAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if let dateFormatter = dateFormatter {
            
            let date = Date(timeIntervalSince1970: value)
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
}
