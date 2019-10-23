//
//  StocksAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by God on 9/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct StockAPIClient {
    static var shared = StockAPIClient()
   
   let stockURL = "https://sandbox.iexapis.com/stable/stock/AAPL/chart/1m?token=Tpk_99a13d1c51654f2ab13764626efa902a"

    func getStocks(completion:@escaping (Result<[Stocks], Error>) -> ()){
        guard let url = URL(string: stockURL) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            //Error handler
            if let err = err {
                completion(.failure(err))
            }
            //success
            do {
                let stocks = try JSONDecoder().decode([Stocks].self, from: data!)
                completion(.success(stocks))
            }
            catch let jsonError {
                completion(.failure(jsonError))
            }
            }.resume()
    }
}

