//
//  EffectView.swift
//  MyCamera1
//
//  Created by 芥川浩平 on 2023/10/24.
//

import SwiftUI

struct EffectView: View {
    //エフェクト編集画面（sheet)の開閉状態を確認
    @Binding var isShowSheet: Bool
    //撮影した写真
    let captureImage: UIImage
    //表示する写真
    @State var showImage: UIImage?
    //フィルタ名を列挙した配列(Array)
    //0.モノクロ
    //1.Chrome
    //2.Fade
    //3.Instant
    //4.Noir
    //5.Process
    //6.Tonal
    //7.Transfer
    //8.SepiaTone
    let filterArray = ["CIPhotoEffectMono",
                       "CIPhotoEffectChrome",
                       "CIPhotoEffectFade",
                       "CIPhotoEffectInstant",
                       "CIPhotoEffectNoir",
                       "CIPhotoEffectProcess",
                       "CIPhotoEffectTonal",
                       "CIPhotoEffectTransfer",
                       "CISepiaTone"
    ]

    //選択中のエフェクト　(filterArrayの数字)
    @State var filterSelectNumber = 0

    var body: some View {
        //縦方向レイアウト
        VStack {
            //スペース確保
            Spacer()

            if let showImage {
                //表示する写真があるときには画面に表示
                Image(uiImage: showImage)
                //リサイズ
                    .resizable()
                //アスペクト比を維持して画面内に収まるように
                    .scaledToFit()
            }//if

            //スペース追加
            Spacer()
            //「エフェクト」ボタン
            Button {
                //ボタンタップした時のアクション
                //フィルタ名を配列から取得
                let filterName = filterArray[filterSelectNumber]

                //次回に適用するフィルタを決めておく
                filterSelectNumber += 1
                //最後のフィルタまで適応した場合
                if filterSelectNumber == filterArray.count {
                    //最後の場合は、最初のフィルタに戻す
                    filterSelectNumber = 0
                }
        
                //元々の画像の回転角度を取得
                let rotate = captureImage.imageOrientation
                //UIImage形式の画像をCIImage形式に変換
                let inputImage = CIImage(image: captureImage)

                //フィルタの種別を引数で指定された種類を指定、CIFilterのインスタンスを取得
                guard let effectFilter = CIFilter(name: filterName) else {
                    return
                }

                //フィルタ加工のパラメータを初期化
                effectFilter.setDefaults()
                //インスタンスにフィルタ加工する元画像を指定
                effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
                //フィルタ加工を行う情報を生成
                guard let outputImage = effectFilter.outputImage else {
                    return
                }

                //CIContextのインスタンスを取得
                let ciContext = CIContext(options: nil)
                //フィルタ加工後の画像をCIContext上に描画し、結果をcgImageとしてCGImage形式の画像を取得
                guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                    return
                }
                //フィルタ加工後の画像をCGImage形式からUIImage形式に変更。その際に回転角度を指定。
                showImage = UIImage(
                    cgImage: cgImage,
                    scale: 1.0,
                    orientation: rotate
                    )
            } label: {
                //テキスト表示
                Text("エフェクト")
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

            //showImageをアンラップ
            if let showImage = showImage? .resized() {
                //captureImageから共有する画像を生成
                let shareImage = Image(uiImage: captureImage)
                //共有シート
                ShareLink(item: shareImage, subject: nil, message: nil, preview: SharePreview("Photo", image: shareImage)) {
                    //テキスト表示
                    Text("シェア")
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
                }//ShareLink
            }//アンラップ
            //「閉じる」ボタン
            Button {
                //ボタンタップした時のアクション
                isShowSheet.toggle()
            } label: {
                //テキスト表示
                Text("閉じる")
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
        }//VStack
        //写真が表示されるときに実行
        .onAppear {
            //撮影した写真を表示する写真に設定
            showImage = captureImage
        } //.onAppearここまで
    }//body
}//EffectView

#Preview {
    EffectView(
        isShowSheet: .constant(true),
        captureImage: UIImage(named: "preview_use")!
    )
}
