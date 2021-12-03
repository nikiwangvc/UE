//
//  TripHistoryViewController.swift
//  UE
//
//  Created by mac pro on 11/16/21.
//

import UIKit
import Charts



class TripHistoryViewController: UIViewController, ChartViewDelegate {

    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Statistics"
        
        lineChart.delegate = self
        // Do any additional setup after loading the view.
        //https://www.youtube.com/watch?v=J9hl7HHXNHU
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width,
                                 height: self.view.frame.size.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        
        //insert mock data
        for x in 0..<10{
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
}
