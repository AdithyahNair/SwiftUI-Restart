//
//  AudioPlayer.swift
//  Restart
//
//  Created by Adithyah Nair on 25/11/22.
//

import AVFoundation
import Foundation

func playSound(sound: String, type: String) {
    var audioPlayer: AVAudioPlayer?
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Cannot play sound.")
        }
    }
}
