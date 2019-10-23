//
//  ContactsDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by God on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!
    
    var detailResult: Results? {
        didSet {
            configureView()
        }
    }

    func configureView() {
        if let detailResults = detailResult {
            if let name = name, let email = email, let age = age, let contactImage = contactImage {
                name.text = detailResults.name.first
                do {
                    let url = URL(string: detailResults.picture.large)!
                    let data = try Data(contentsOf: url)
                    self.contactImage.image = UIImage(data: data)
                }
                catch{
                    print(error)
                }
                email.text = detailResults.email
                age.text = "\(detailResults.dob)"
                title = detailResults.name.last
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            configureView()
        let radius = contactImage.frame.width/2.0
        contactImage.layer.cornerRadius = radius
        contactImage.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
