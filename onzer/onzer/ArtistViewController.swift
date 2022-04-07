//
//  ArtistViewController.swift
//  onzer
//
//  Created by Axel Demorest on 07/04/2022.
//

import UIKit

class ArtistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var artistPicture: UIImageView!
    @IBOutlet weak var albumTableVIew: UITableView!
    @IBOutlet weak var artistName: UILabel!
    
    public var artistId: Int = 0
    public var artistVariableName: String = ""
    public var artistVariablePicture: String = ""
    
    var albums: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumTableVIew.delegate = self
        albumTableVIew.dataSource = self
        
        artistName.text = artistVariableName
        artistPicture.image = ApiManager().getImageFromUrl(urlStr: artistVariablePicture)
        
        ApiManager().fetchAlbumsFromArtistId(id: self.artistId, completion: { data, error in
            self.albums = data
            
            DispatchQueue.main.async {
                self.albumTableVIew.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleArtistTableViewCell", for: indexPath) as! SingleArtistTableViewCell
        cell.albumName.text = album.name
        cell.albumCover.image = ApiManager().getImageFromUrl(urlStr: album.cover)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumController") as? AlbumTableViewController {
            
            vc.albumVariableName = albums[indexPath.row].name
            vc.albumVariableId = albums[indexPath.row].id

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}
