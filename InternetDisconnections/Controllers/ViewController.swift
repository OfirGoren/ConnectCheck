//
//  ViewController.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 03/11/2022.
//

import UIKit
import ActivityKit
import WidgetKit
class ViewController: UIViewController {
    
    
    @IBOutlet weak var barChart: BarChart!
    @IBOutlet weak var tableView: UITableView!
    let numOfHours = 24
    var internetDisconnectionsList = [DisconnectionsCell.ViewModel]()
    let sqlHandler = SQLiteHandler()
    
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        initTableViewCell()
        initTableViewDelegate()
        setupAllData()
        
    
        
        // sqlHandler.increaseAmountValueByOne(column: .is00)
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
    
    
    @IBAction func resetDataBaseClicked(_ sender: UIButton) {
        
        Task {
            LocalState.hasAlreadyInitRows = false
            await sqlHandler.deleteAll()
            await sqlHandler.initRows()
            setupAllData()
        }
    }
    
    
}




// initTableView
extension ViewController {
    
    func initTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initTableViewCell() {
        tableView.register(DisconnectionsCell.registerCell, forCellReuseIdentifier: DisconnectionsCell.cellReuseIdentifier)
        tableView.rowHeight = DisconnectionsCell.cellHeight
        
    }
    
    
}



// reload TableView Data (display amount internet Disconnections)
extension ViewController {
    
    func reloadDataToInternatDisconnectionsList(data:[SQLiteHandler.ViewModel]?) {
        
        internetDisconnectionsList = InternetDisDataHandler.getDataToInternatDisconnectionsList(data: data)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

// reload BarChart Data
extension ViewController:UITableViewDelegate {
    
    func reloadBarChartData(data:[SQLiteHandler.ViewModel]?) {
        DispatchQueue.main.async {
            self.barChart.setupData(data: BarChartDataHadler.getBarChartData(data: data))
        }
        
    }
  
    
}



extension ViewController {
    func setupAllData() {
        
        Task {
            let getData = await sqlHandler.getRows()
            Task {
                reloadDataToInternatDisconnectionsList(data: getData)
            }
            reloadBarChartData(data: getData)
            
        }
  
    }
    
    
    
    
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return internetDisconnectionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DisconnectionsCell.cellReuseIdentifier, for: indexPath) as! DisconnectionsCell
        cell.setup(data: internetDisconnectionsList[indexPath.row])
        return cell
        
    }
    
    
    
    
    
}

