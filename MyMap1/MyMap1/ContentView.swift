//
//  ContentView.swift
//  MyMap1
//
//  Created by 芥川浩平 on 2023/10/11.
//

import SwiftUI

struct ContentView: View {
    //入力中の文字列を保持する状態変数
    @State private var inputText = ""
    //検索キーワードを保持する状態変数
    @State private var displaySearchKey = ""
    //マップ種類　最初は標準から
    @State private var displayMapType: MapType = .standard
    
    var body: some View {
        //垂直方向レイアウト
        VStack {
            //テキストフィールド
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
            //入力が完了されたとき
                .onSubmit {
                    //入力が完了したので検索キーワードに設定する
                    displaySearchKey = inputText
                }
            //余白の追加
                .padding()
            
            //奥から手前方向にレイアウト（右下基準で配置）
            ZStack(alignment: .bottomTrailing) {
                //マップを表示
                MapView(searchKey: displaySearchKey, mapType: displayMapType)
                
                //マップ表示切り替えボタン
                Button {
                    //標準→衛星写真→衛星写真＋交通機関ラベル
                    switch displayMapType {
                    case .standard:
                        displayMapType = .satellite
                    case .satellite:
                        displayMapType = .hybrid
                    case .hybrid:
                        displayMapType = .standard
                    }
                } label: {
                    //マップアイコンの表示
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                }
                //右の余白を20開ける
                .padding(.trailing, 20.0)
                //下の余白を30開ける
                .padding(.bottom, 30.0)
                
            }
        }
    }
}

#Preview {
    ContentView()
}
