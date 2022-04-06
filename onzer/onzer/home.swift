//
//  home.swift
//  onzer
//
//  Created by Alexis Majchrzak on 05/04/2022.
//

import UIKit

class home: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    struct Artiste {
        let imageSon: String
        let titleSon: String
        let titleArtiste: String
        let albumArtiste: String
    }
    
    let data: [Artiste] = [
        Artiste(imageSon: "AppIcon", titleSon: "Au DD", titleArtiste: "PNL", albumArtiste: "Deux frères"),
        Artiste(imageSon: "AppIcon", titleSon: "Autre monde", titleArtiste: "PNL", albumArtiste: "Deux frères"),
        Artiste(imageSon: "AppIcon", titleSon: "Deux frères", titleArtiste: "PNL", albumArtiste: "Deux frères"),
        Artiste(imageSon: "AppIcon", titleSon: "Déconnecté", titleArtiste: "PNL", albumArtiste: "Deux frères")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artiste = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "artisteCell", for: indexPath) as! ArtisteTableViewCell
        cell.imageSon.image = UIImage(named: artiste.imageSon)
        cell.titleSon.text = artiste.titleSon
        cell.titleArtiste.text = artiste.titleArtiste
        cell.albumArtiste.text = artiste.albumArtiste
        
        return cell
    }

}
