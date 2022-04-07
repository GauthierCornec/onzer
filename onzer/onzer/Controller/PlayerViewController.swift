//
//  PlayerViewController.swift
//  onzer
//
//  Created by Alexis Majchrzak on 05/04/2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    public var albumVariableCover: String = ""
    public var trackVariableName: String = ""
    public var trackVariablePreview: String = ""
    public var artistVariableName: String = ""
    
    @IBOutlet weak var testuButton: UIButton!
    
    var audioPlayer: AVPlayer?
    
    @IBOutlet weak var trackCover: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var sliderVolume: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: trackVariablePreview) else {
            print("error to get the mp3 file")
            return
        }
        
        do {
            audioPlayer = try AVPlayer(url: url as URL)
        } catch {
            print("audio file error")
        }
        
        testuButton.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
        
        audioPlayer!.play()

        trackCover.image =  ApiManager().getImageFromUrl(urlStr: albumVariableCover)
        trackTitle.text = trackVariableName
        artistName.text = artistVariableName
    }
    
    @IBAction func testButtonPlay(_ sender: Any) {
        if audioPlayer?.rate == 0
            {
                audioPlayer!.play()
                testuButton.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
            } else {
                audioPlayer!.pause()
                testuButton.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
            }
    
        
    }

}
