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
    //SafariViewの表示有無を管理する変数
    @State var showSafari = false

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

            //リスト表示する
            List(okashiDataList.okashiList) { okashi in
                //１つ１つの要素を取り出す
                //ボタンを用紙
                Button {
                    //選択したリンクを保存する
                    okashiDataList.okashiLink = okashi.link
                    //SafariViewを表示
                    showSafari.toggle()
                } label: {
                    //Listの表示内容を生成する
                    //水平方向レイアウト
                    HStack {
                        //画像を読み込み、表示する
                        AsyncImage(url: okashi.image) { image in
                            //画像を表示する
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            //読み込み中はインジケーターを表示
                            ProgressView()
                        }
                        //テキスト表示
                        Text(okashi.name)
                    }//HStack
                }//Button
            }//List
            .sheet(isPresented: $showSafari, content: {
                //SafariViewを表示
                SafariView(url: okashiDataList.okashiLink!)
                //画面下部がセーフエリア外までいっぱいになるように指定
                    .ignoresSafeArea(edges: [.bottom])
            }) //sheet
        }//VStack
    }// body
}// ContentView

#Preview {
    ContentView()
}
