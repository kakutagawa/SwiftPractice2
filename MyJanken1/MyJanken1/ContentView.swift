//
//  ContentView.swift
//  MyJanken1
//
//  Created by 芥川浩平 on 2023/10/09.
//

import SwiftUI

struct ContentView: View {
    //じゃんけん結果を格納する変数（0=初期画面、1=グー、2=チョキ、3=パー）
    @State var answerNumber = 0
    
    var body: some View {
        
        VStack {
            //スペース
            Spacer()
            //数字が0だったら
            if answerNumber == 0 {
                //初期画面
                Text("これからじゃんけんをします！")
                //下辺に余白を設定
                    .padding(.bottom)
            } else if answerNumber == 1 {
                //数字が1だったら、グーを指定
                //グー画像を指定
                Image ("gu")
                //リサイズ
                    .resizable()
                //アスペクト比の維持
                    .scaledToFit()
                //スペース
                Spacer()
                //じゃんけんの種類
                Text("グー")
                //下辺に余白を設定
                    .padding(.bottom)
            } else if answerNumber == 2 {
                //数字が2だったら、チョキを指定
                //チョキ画像を指定
                Image ("choki")
                //リサイズ
                    .resizable()
                //アスペクト比の維持
                    .scaledToFit()
                //スペース
                Spacer()
                //じゃんけんの種類
                Text("チョキ")
                //下辺に余白を設定
                    .padding(.bottom)
            } else {
                //数字が3だったら、パーを指定
                //パー画像を指定
                Image ("pa")
                //リサイズ
                    .resizable()
                //アスペクト比の維持
                    .scaledToFit()
                //スペース
                Spacer()
                //じゃんけんの種類
                Text("パー")
                //下辺に余白を設定
                    .padding(.bottom)
            }
            
            
            //ボタン
            Button {
                //新しいじゃんけんの結果を一時的に格納する変数
                var newAnswerNumber = 0
                
                //ランダムに結果を出すが、前回と異なる結果のみ採用
                repeat {
                    //1,2,3をランダムに算出
                    newAnswerNumber = Int.random(in: 1...3)
                    //前回と同じ結果の時は再度ランダムに数字を出す
                    //異なる結果の場合、リピートを抜ける
                } while answerNumber == newAnswerNumber
                
                //新しいじゃんけんの結果を格納
                answerNumber = newAnswerNumber
            } label: {
                //ボタンの文字を指定
                Text("じゃんけんをする！")
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .font(.title)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
