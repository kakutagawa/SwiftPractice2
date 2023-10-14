//
//  SoundPlayer.swift
//  MyMusic1
//
//  Created by 芥川浩平 on 2023/10/10.
//

import UIKit
import AVFoundation

enum Const {
    static let cymbalSound = "cymbalSound"
    static let guitarSound = "guitarSound"
}

final class SoundPlayer: NSObject {
    //シンバルの音源データ読み込み
    private let cymbalData = NSDataAsset(name: Const.cymbalSound)?.data
    //シンバル用プレイヤーの変数
    private var cymbalPlayer: AVAudioPlayer?

    //ギターの音源データ読み込み
    private let guitarData = NSDataAsset(name: Const.guitarSound)?.data
    //ギター用プレイヤーの変数
    private var guitarPlayer: AVAudioPlayer?

    func cymbalPlay() {
        do {
            //シンバル用プレイヤーに音源データを指定
            if let cymbalData {
                cymbalPlayer = try AVAudioPlayer(data: cymbalData)
            }
            //シンバルの音源再生
            cymbalPlayer?.play()
        } catch {
            print("シンバルで、エラーが発生しました！")
        }
    }//cymbalPlayここまで
    
    func guitarPlay() {
        do {
            //ギター用プレイヤーに音源データを指定
            guard let guitarData else {
                return
            }
            guitarPlayer = try AVAudioPlayer(data: guitarData)
            //ギターの音源再生
            guitarPlayer?.play()
        } catch {
            print("ギターで、エラーが発生しました！")
        }
    }//guitarPlayここまで

}
