//
//  ContentView.swift
//  MyCamera1
//
//  Created by 芥川浩平 on 2023/10/18.
//

import SwiftUI

struct ContentView: View {
    //撮影した写真を保持する状態変数
    @State private var captureImage: UIImage? = nil
    //撮影画面(sheet)の開閉状態を管理
    @State private var isShowSheet = false

    var body: some View {
        VStack {
            //スペース追加
            Spacer()
            //撮影した写真がある時
            if let captureImage {
                //撮影写真を表示
                Image (uiImage: captureImage)
                //リサイズ
                    .resizable()
                //アスペクト比を維持して画面に収める
                    .scaledToFit()
            }
            //スペース追加
            Spacer()
            //ボタン
            Button {
                //ボタンタップした時のアクション
                //カメラが利用可能かチェック
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    print("カメラは利用できます")
                    //カメラが使えるなら、isShowSheetをtrue
                    isShowSheet.toggle()
                } else {
                    print("カメラは利用できません")
                }
            } label: {
                //テキスト表示
                Text("カメラを起動する")
                //横幅いっぱい
                    .frame(maxWidth: .infinity)
                //高さ50ポイントを指定
                    .frame(height: 50)
                //文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                //背景青色
                    .background(.blue)
                //文字白色
                    .foregroundColor(.white)
            }//ボタン
            //上下左右に余白を追加
            .padding()
            //sheetを表示
            //isPresentedで指定した状態変数がtrueの時実行
            .sheet(isPresented: $isShowSheet) {
                //UIImagePickerController（写真撮影）を表示
                ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
            }//「カメラを起動する」ボタンのシートここまで
        }//VStack
    }//body
}//ContentView

#Preview {
    ContentView()
}
