//
//  SettingView.swift
//  MyTimer1
//
//  Created by 芥川浩平 on 2023/10/12.
//

import SwiftUI

struct SettingView: View {
    //秒数設定
    @State private var timerValue = 10
    var body: some View {
        //奥から手前方向にレイアウト
        ZStack {
            //背景色
            Color("backgroundSetting")
            //セーフエリアを超えて画面全体配置
                .ignoresSafeArea()
            //垂直レイアウト
            VStack {
                //スペースを開ける
                Spacer()
                //テキスト表示
                Text("\(timerValue)秒")
                //文字サイズ
                    .font(.largeTitle)
                //スペース
                Spacer()
                //Pickerの表示
                Picker(selection: $timerValue) {
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                } label: {
                    Text("選択")
                }
                //Pickerをホイール表示
                .pickerStyle(.wheel)
            }//VStack
        }//ZStack
    }//body
}//SettingView

#Preview {
    SettingView()
}
