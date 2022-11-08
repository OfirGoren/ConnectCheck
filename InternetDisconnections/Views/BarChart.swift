
import UIKit
import Charts

class BarChart:BarChartView{
    
    struct ViewModel {
        let y:Double
        
    }
    
    private var entries = [BarChartDataEntry]()
    private let barChartDescription = "Internet disconnect num of occurrences"
    private let months = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11","12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configuration()
    }
    
    
    private func configuration() {
        doubleTapToZoomEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 24
        leftAxis.axisMinimum = 0.0
        rightAxis.drawLabelsEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        xAxis.granularity = 1
        //xAxis.setLabelCount(months.count, force: true)
        
        
    }
    
    func setupData(data:[ViewModel]) {
        
        entries.removeAll()
        
        for (index, element) in data.enumerated() {
            
            entries.append(BarChartDataEntry(x:Double(index), y: element.y))
            
        }
        
        
        let set = BarChartDataSet(entries: entries, label: barChartDescription)
        set.colors = [UIColor("11458E")]
        let data = BarChartData(dataSet: set)
        self.data = data
        
    }
    
    
}



