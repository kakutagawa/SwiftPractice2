//
//  ContentView.swift
//  MyMusic1
//
//  Created by 芥川浩平 on 2023/10/10.
//

import SwiftUI

struct ContentView: View {
    private let soundPlayer = SoundPlayer()

    var body: some View {
        ZStack {
            //背景画像の表示
            BackgroundView(imageName: "background")
            
            HStack {
                Button {
                    //ボタンタップした時のアクション
                    soundPlayer.cymbalPlay()
                } label: {
                    Image("cymbal")
                }//シンバルここまで
                Button {
                    //ボタンタップした時のアクション
                    soundPlayer.guitarPlay()
                } label: {
                    Image("guitar")
                }//ギターここまで
            }//HStack
        }//ZStack
    }
}

#Preview {
    ContentView()
}
