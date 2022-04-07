//
//  SearchViewController.swift
//  onzer
//
//  Created by Alexis Majchrzak on 05/04/2022.
//

import UIKit



class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
//    var artistsArray:[Artist] = [Artist(id: 1234, name: "TEST")]
    @IBOutlet weak var searchTableView: UITableView!
    
    var data: [Artist] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        if searchText.count >= 1 {
            ApiManager().fetchArtists(searchText:searchText) { (data, error) in
                self.data = data

                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArtistViewController") as? ArtistViewController {
            vc.artistId = data[indexPath.row].id
            vc.artistVariableName = data[indexPath.row].name
            vc.artistVariablePicture = data[indexPath.row].picture
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchArtistCell", for: indexPath) as! SearchArtistTableViewCell
        cell.artistImage.image = ApiManager().getImageFromUrl(urlStr: artist.picture)
        cell.artistName.text = artist.name
        
        return cell
    }
    
}
