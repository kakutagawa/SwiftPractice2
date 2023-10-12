//
//  ContentView.swift
//  MyJanken1
//
//  Created by 芥川浩平 on 2023/10/09.
//

import SwiftUI

enum Janken: CaseIterable {
    case gu
    case choki
    case pa
    
    var imagePath: String {
        switch self {
        case .gu:
            return "gu"
        case .choki:
            return "choki"
        case .pa:
            return "pa"
        }
    }
    
    var text: String {
        switch self {
        case .gu:
            return "グー"
        case .choki:
            return "チョキ"
        case .pa:
            return "パー"
        }
    }
}


struct ContentView: View {
    //じゃんけん結果を格納する変数
    @State private var answer: Janken?

    var body: some View {
        VStack {
            //スペース
            Spacer()
            
            if let answer {
                //画像を指定
                Image(answer.imagePath)
                    //リサイズ
                    .resizable()
                    //アスペクト比の維持
                    .scaledToFit()
                //スペース
                Spacer()
                //じゃんけんの種類
                Text(answer.text)
                //下辺に余白を設定
                    .padding(.bottom)
            
            } else {
                //初期画面
                Text("これからじゃんけんをします！")
                    //下辺に余白を設定
                    .padding(.bottom)
            }
            //ボタン
            Button {
                //新しいじゃんけんの結果を一時的に格納する変数
                var newAnswer: Janken?
                
                //ランダムに結果を出すが、前回と異なる結果のみ採用
                repeat {
                    //gu,choki,paをランダムに算出
                    newAnswer = Janken.allCases.randomElement()
                    //前回と同じ結果の時は再度ランダムに出す
                    //異なる結果の場合、リピートを抜ける
                } while answer == newAnswer
                
                //新しいじゃんけんの結果を格納
                answer = newAnswer
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
