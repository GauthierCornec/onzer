//
//  home.swift
//  onzer
//
//  Created by Alexis Majchrzak on 05/04/2022.
//

import UIKit
import AVFoundation


class home: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    var audioPlayer : AVPlayer!

    
    struct Artiste {
        let imageSon: String
        let titleSon: String
        let titleArtiste: String
        let albumArtiste: String
    }
    
    var data: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        ApiManager().fetchTracksFromArtists(searchText: "pnl") { data, error in
            self.data = data
            print(data)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "artisteCell", for: indexPath) as! ArtisteTableViewCell
        cell.imageSon.image = UIImage(named: "AppIcon")
        cell.titleSon.text = song.title
        cell.titleArtiste.text = song.title
        cell.albumArtiste.text = song.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = data[indexPath.row]
        self.playAudioFromURL(songURL: song.preview)
    }
    
    private func playAudioFromURL(songURL: String) {
            guard let url = URL(string: songURL) else {
                print("error to get the mp3 file")
                return
            }
            do {
                audioPlayer = try AVPlayer(url: url as URL)
            } catch {
                print("audio file error")
            }
            audioPlayer?.play()
        
        }


}
