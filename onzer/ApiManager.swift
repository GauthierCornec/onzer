//
//  ApiManager.swift
//  onzer
//
//  Created by administration4 on 05/04/2022.
//

import Foundation

class ApiManager {
    
    let baseURL = "https://api.deezer.com/"
    var urlAlbum = "album/302127"
    var artistsArray = [Artist]()

    
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
                            
                            let artist = Artist(id: id!, name: name!)
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
        
        let strUrl = "\(baseURL)album/\(id)"
        let url = URL(string: strUrl)!
        
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
                            let id = item["id"] as? Int
                            let title = item["title"] as? String
                            
                            let myAlbum = Album(id: id!, name: title!)
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
                                    
                                    let song = Song(preview: preview!, title: title!)
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
}

struct Artist {
    var id: Int
    var name: String
}

struct Song {
    var preview: String
    var title: String
}