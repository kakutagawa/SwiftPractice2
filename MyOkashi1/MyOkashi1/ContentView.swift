//
//  ContentView.swift
//  MyOkashi1
//
//  Created by 芥川浩平 on 2023/10/25.
//

import SwiftUI

struct ContentView: View {
    //OkashiDataを参照する状態変数
    @StateObject var okashiDataList = OkashiData()
    //入力された文字列を保持する状態変数
    @State var inputText = ""

    var body: some View {
        //垂直レイアウト
        VStack {
            //文字を受け取るTextFieldを表示する
            TextField("キーワード" ,
                      text: $inputText,
                      prompt: Text("キーワードを入力してください"))
            .onSubmit {
                //入力完了直後に検索する
                okashiDataList.searchOkashi(keyword: inputText)
            }// .onSubmit
            //キーボードの改行を検索に変更する
            .submitLabel(.search)
            //上下左右に空白
            .padding()
        }//VStack
    }// body
}// ContentView

#Preview {
    ContentView()
}
