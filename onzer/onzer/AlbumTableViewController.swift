//
//  AlbumTableViewController.swift
//  onzer
//
//  Created by Merwan Laouini on 06/04/2022.
//

import UIKit


class TestSong{
    var Songname : String
    var Albumname : String
    
    
    init( from  TestSong : String, Album : String){
        self.Songname = TestSong
        self.Albumname = Album
    }
    
}

class AlbumTableViewController: UITableViewController {
    
    @IBOutlet var tableViewTracks: UITableView!
    
    public var albumVariableName: String = ""
    public var albumVariableId: Int = 0
    var data: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewTracks.delegate = self
        tableViewTracks.dataSource = self
        
        ApiManager().fetchTracksFromAlbumId(id: self.albumVariableId) { data, error in
            self.data = data
            
            DispatchQueue.main.async {
                self.tableViewTracks.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "SongCell") as! AlnumCell
        
        cell.SongName.text = data[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "player") as? PlayerViewController {
            
            vc.albumVariableCover = data[indexPath.row].albumImage
            vc.trackVariablePreview = data[indexPath.row].preview
            vc.trackVariableName = data[indexPath.row].title
            vc.artistVariableName = data[indexPath.row].artistName
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

     
}
