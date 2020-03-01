//
//  PlanViewController.swift
//  UberTest
//
//  Created by Elizabeth Song on 2/29/20.
//  Copyright © 2020 Elizabeth. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController {
    var foodplace = ""
    var parkplace = ""

    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var park: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(foodplace)
        print(parkplace)
        food.text = foodplace
        park.text = parkplace
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
