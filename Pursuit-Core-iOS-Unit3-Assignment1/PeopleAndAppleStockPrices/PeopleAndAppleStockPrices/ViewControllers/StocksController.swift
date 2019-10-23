//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by God on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var StocksTableView: UITableView!
    

    var stockInfo = [StocksByMonthAndYear]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStockData()
        StocksTableView.dataSource = self
        StocksTableView.delegate = self
    }
    private func loadStockData() {
           stockInfo = Stocks.getStocksSortedByMonthAndYear()
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockInfo[section].stocks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return stockInfo.count
       }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stock = stockInfo[section]
        return "\(stock.month) \(stock.year).AVG: \(stock.getMonthAverage())"
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stockInfo[indexPath.section].stocks[indexPath.row]
        let cell = StocksTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)

        cell.textLabel?.text = "\(stock.day) \(stock.month) \(stock.year)"
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
}

extension StocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "StockDetailViewController") as? StockDetailViewController{
            nextViewController.allStocks = stockInfo[indexPath.section].stocks[indexPath.row]
        
        navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}


