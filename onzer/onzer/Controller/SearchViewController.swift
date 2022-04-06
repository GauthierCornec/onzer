//
//  SearchViewController.swift
//  onzer
//
//  Created by Alexis Majchrzak on 05/04/2022.
//

import UIKit



class SearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
//    var artistsArray:[Artist] = [Artist(id: 1234, name: "TEST")]

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        if searchText.count > 1 {
            ApiManager().fetchArtists(searchText:searchText) { (data, error) in
                print(data)
//                self.artistsArray = data
             
            }
        }
        
    }
    
}
