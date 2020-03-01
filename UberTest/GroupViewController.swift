//
//  GroupViewController.swift
//  UberTest
//
//  Created by Elizabeth Song on 3/1/20.
//  Copyright © 2020 Elizabeth. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var phoneDict = [
    "2587788398": "Elizabeth Song",
    "5107784433": "Naomi Nunis",
    "3478749988": "Mariam Germanyan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        print("searchText \(searchText)")
        var phoneNumber = searchText
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        print("searchText \(searchBar.text)")
        var phoneNumber = searchBar.text
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
