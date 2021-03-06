//
//  ApiManager.swift
//  onzer
//
//  Created by administration4 on 05/04/2022.
//

import Foundation
import UIKit

class ApiManager {
    
    let baseURL = "https://api.deezer.com/"
    var urlAlbum = "album/302127"
    var artistsArray = [Artist]()
    
    func getImageFromUrl(urlStr: String) -> UIImage {
        let url = URL(string: urlStr)
        var image = UIImage(named: "test")
        if let data = try? Data(contentsOf: url!) {
            image = UIImage(data: data)
        }
        return image!
    }

    func fetchTracksFromArtists(searchText: String ,completion: @escaping (_ data : [Song], _ error: Error?) -> Void){
        var tracksArray = [Song]()
        let strUrl = "\(baseURL)search?q=" + searchText
        let url = URL(string: strUrl)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        let trueData = data["data"] as? [[String:AnyObject]]
                        //print(trueData)
                        for item in trueData! {
                            let preview = item["preview"] as? String
                            let title = item["title"] as? String
                            let artistName = item["artist"]?["name"] as? String
                            let albumImage = item["album"]?["cover"] as? String
                            let albumName = item["album"]?["title"] as? String
                            
                            let song = Song(preview: preview!, title: title!, artistName: artistName!, albumImage: albumImage!, albumName: albumName!)
                            tracksArray.append(song)
                        }
                        //print(artistsArray)
                        completion(tracksArray, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchArtists(searchText:String ,completion: @escaping (_ data : [Artist], _ error: Error?) -> Void){
        let strUrl = "\(baseURL)search/artist?q=" + searchText
        let url = URL(string: strUrl)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        let trueData = data["data"] as? [[String:AnyObject]]
                        //print(trueData)
                        for item in trueData! {
                            let name = item["name"] as? String
                            let id = item["id"] as? Int
                            let picture = item["picture"] as? String

                            
                            let artist = Artist(id: id!, name: name!, picture: picture!)
                            //print(artist)
                            self.artistsArray.append(artist)
                        }
                        //print(artistsArray)
                        completion(self.artistsArray, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchAlbumsFromArtistId(id: Int,completion: @escaping (_ data : [Album], _ error: Error?) -> Void) -> Void {
        
        var albumsArray = [Album]()
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let strUrl = "\(baseURL)artist/\(id)/albums"
        let url = URL(string: strUrl)!
        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        let trueData = data["data"] as? [[String:AnyObject]]
                        for item in trueData! {
                            let id = item["id"] as? Int
                            let title = item["title"] as? String
                            let cover = item["cover"] as? String
                            
                            let myAlbum = Album(id: id!, name: title!, cover: cover!)
                            albumsArray.append(myAlbum)
                        }
                        completion(albumsArray, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func fetchTracksFromAlbumId(id:Int, completion: @escaping (_ data : [Song], _ error: Error?) -> Void) -> Void {
        var tracksArray = [Song]()
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let strUrl = "\(baseURL)album/\(id)"
        let url = URL(string: strUrl)!
        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        if let tracks = data["tracks"] as? [String:AnyObject] {
                            if let tracksData = tracks["data"] as? [[String:AnyObject]]{
                                for item in tracksData {
                                    let preview = item["preview"] as? String
                                    let title = item["title"] as? String
                                    let artistName = item["artist"]?["name"] as? String
                                    
                                    let song = Song(preview: preview!, title: title!, artistName: artistName!, albumImage: data["cover"] as! String, albumName: data["title"] as! String)
                                    tracksArray.append(song)

                                }
                            }
                        }
        
                        completion(tracksArray, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
}

struct Album {
    var id: Int
    var name: String
    var cover: String
}

struct Artist {
    var id: Int
    var name: String
    var picture: String
}

struct Song {
    var preview: String
    var title: String
    var artistName: String
    var albumImage: String
    var albumName: String
}
