//
//  Contacts API Client.swift
//  PeopleAndAppleStockPrices
//
//  Created by God on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

struct ContactAPIClient {
    static var shared = ContactAPIClient()
    let contactURL = "https://randomuser.me/api/?results=50"

    func getContact(completion:@escaping (Result<ResultsWrapper, Error>) -> ()){
        guard let url = URL(string: contactURL) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            //Error handler
            if let err = err {
                completion(.failure(err))
            }
            //success
            do {
                let contacts = try JSONDecoder().decode(ResultsWrapper.self, from: data!)
                completion(.success(contacts))
            }
            catch let jsonError {
                completion(.failure(jsonError))
            }
            }.resume()
    }
}

