//
//  ViewController.swift
//  Video & Audio Settings
//
//  Created by Engy on 11/1/24.
//

import UIKit
import AVFoundation
import AVKit


class ViewController: UIViewController {
    @IBOutlet var videoVolume: UISlider!
    @IBOutlet var pianoVolume: UISlider!
    @IBOutlet var roundedButtons: [UIButton]!
    @IBOutlet weak var videoView: UIView!
    var playerViewController: AVPlayerViewController?
    var audioPlayer: AVAudioPlayer?
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoPlayer()
        roundedButtons.forEach{$0.layer.cornerRadius = 10}

    }

    func setupVideoPlayer() {
        guard let url = Bundle.main.url(forResource: "videoplayback", withExtension: "mp4") else { return }
        player = AVPlayer(url: url)

        playerViewController = AVPlayerViewController()
        playerViewController?.player  = player
        // Present the player view controller
        if let playerVC = playerViewController {
            playerVC.view.frame = videoView.bounds
            videoView.addSubview(playerVC.view)
//            playerVC.player?.play()
        }

    }

    func getNoteName(_ tag: Int) -> String {
        switch tag {
        case 1: return "A"
        case 2: return "B"
        case 3: return "C"
        case 4: return "D"
        case 5: return "E"
        case 6: return "F"
        case 7: return "G"
        default: return ""
        }
    }
    func playSound(note: String) {
        guard let url = Bundle.main.url(forResource: note, withExtension: "wav") else {return}
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = pianoVolume.value
            audioPlayer?.play()
        } catch {
            print("Error loading sound: \(error)")
        }

    }

    @IBAction func playsoundButtonClicked (_ sender:UIButton) {
        let noteName = getNoteName(sender.tag)
        playSound(note: noteName)
    }

    @IBAction func videoVolumeChanged(_ sender: UISlider) {
        player?.volume = sender.value
    }
}

//    func setupVideoPlayer(){
//        guard let url =  Bundle.main.url(forResource: "videoplayback", withExtension: "mp4") else {return}
//        player = AVPlayer(url: url)
//
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = videoView.bounds
//        playerLayer.videoGravity = .resizeAspect
//
//        videoView.layer.addSublayer(playerLayer)
//        player?.play()
//    }

