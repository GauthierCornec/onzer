//
//  AlbumTableViewController.swift
//  onzer
//
//  Created by Alexis Majchrzak on 06/04/2022.
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
    
    let data: [TestSong] = [TestSong(from: "Sundance", Album: "Adios Bahamas"),TestSong(from: "En face", Album: "Adios Bahamas"),TestSong(from: "vibe", Album: "Adios Bahamas"),TestSong(from: "Daruma", Album: "Adios Bahamas")]

    override func viewDidLoad() {
        super.viewDidLoad()

    
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
        
        cell.SongName.text = data[indexPath.row].Songname
        cell.AlbumName.text = data[indexPath.row].Albumname
        
        
        return cell
    }

     
}
