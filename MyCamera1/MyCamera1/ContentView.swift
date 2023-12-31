//
//  ContentView.swift
//  MyCamera1
//
//  Created by 芥川浩平 on 2023/10/18.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    //撮影した写真を保持する状態変数
    @State private var captureImage: UIImage? = nil
    //撮影画面(sheet)の開閉状態を管理
    @State private var isShowSheet = false
    //フォトライブラリーで選択した写真を整理
    @State private var photoPickerSelectedImage: PhotosPickerItem? = nil

    var body: some View {
        VStack {
            //スペース追加
            Spacer()
            //ボタン
            Button {
                //ボタンタップした時のアクション
                //カメラが利用可能かチェック
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    print("カメラは利用できます")
                    //撮影写真を初期化する
                    captureImage = nil
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
                if let captureImage {
                    //撮影した写真がある→EffectViewを実行する
                    EffectView(isShowSheet: $isShowSheet, captureImage: captureImage)
                } else {
                    //UIImagePickerController（写真撮影）を表示
                    ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                }
            }//「カメラを起動する」ボタンのシートここまで

            //フォトライブラリーから選択する
            PhotosPicker(selection: $photoPickerSelectedImage, matching: .images, preferredItemEncoding: .automatic, photoLibrary: .shared()) {
                //テキスト表示
                Text("フォトライブラリーから選択する")
                //横幅いっぱい
                    .frame(maxWidth: .infinity)
                //高さ50ポイント
                    .frame(height: 50)
                //背景青色
                    .background(.blue)
                //文字色を白色に
                    .foregroundColor(.white)
                //上下左右に余白
                    .padding()
            }//PhotosPickerここまで
            //選択した写真情報をもとに写真を取り出す
            .onChange(of: photoPickerSelectedImage) { _, PhotosPickerItem in
                //選択した写真がある時
                if let PhotosPickerItem {
                    //Data型で写真を取り出す
                    PhotosPickerItem.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            //写真がある時
                            if let data {
                                //撮影写真を初期化する
                                captureImage = nil
                                //写真をcaptureImageに保存
                                captureImage = UIImage(data: data)
                            }
                        case .failure:
                            return
                        }
                    }
                }
            }//Onchange
        }//VStack
        //撮影した写真を保持する状態変数が変化したら実行する
        .onChange(of: captureImage) { _, image in
            if let _ = image {
                //撮影した写真がある→EffectViewを表示する
                isShowSheet.toggle()
            }
        }
    }//body
}//ContentView

#Preview {
    ContentView()
}
