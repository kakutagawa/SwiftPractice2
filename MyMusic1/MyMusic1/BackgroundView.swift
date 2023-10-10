//
//  BackgroundView.swift
//  MyMusic1
//
//  Created by 芥川浩平 on 2023/10/10.
//

import SwiftUI

struct BackgroundView: View {
    //画像ファイル名
    let imageName: String
    var body: some View {
        //背景画像の指定
        Image(imageName)
        //リサイズ
            .resizable()
        //画面いっぱいになるようにセーフエリア外まで表示されるように指定
            .ignoresSafeArea()
        //アスペクト比を維持して短辺基準に収まるように
            .scaledToFill()
    }
}

#Preview {
    BackgroundView(imageName: "background")
}
