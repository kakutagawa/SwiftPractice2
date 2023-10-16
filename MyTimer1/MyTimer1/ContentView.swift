//
//  ContentView.swift
//  MyTimer1
//
//  Created by 芥川浩平 on 2023/10/12.
//

import SwiftUI

struct ContentView: View {
    //タイマーの変数を作成
    @State private var timerHandler : Timer?
    //カウント（経過時間）の変数を作成
    @State private var count = 0
    //永続化する秒数設定（初期値は10)
    @AppStorage("timer_value") private var timerValue = 10
    //アラート表示有無
    @State var showAlert = false

    var body: some View {
        NavigationStack {
            //奥から手前方向にレイアウト
            ZStack {
                //背景画像
                Image("backgroundTimer")
                //リサイズ
                    .resizable()
                //セーフエリアを超えて画面全体に配置
                    .ignoresSafeArea()
                //アスペクト比を維持して短辺基準に
                    .scaledToFill()
                //垂直方向レイアウト
                //View(部品)間の間隔を30に
                VStack(spacing: 30.0) {
                    //テキスト表示
                    Text("残り\(timerValue - count)秒")
                    //文字サイズの指定
                        .font(.largeTitle)
                    //水平方向レイアウト
                    HStack {
                        //スタートボタン
                        Button {
                            //ボタンタップ時のアクション
                            //タイマーをカウントダウン開始する関数
                            startTimer()

                        } label: {
                            Text("スタート")
                            //文字サイズ
                                .font(.title)
                            //文字色を白に
                                .foregroundColor(Color.white)
                            //幅高さを140に
                                .frame(width: 140, height: 140)
                            //背景を設定
                                .background(Color("startColor"))
                            //円形にくり抜く
                                .clipShape(Circle())
                        }
                        //ストップボタン
                        Button {
                            //ボタンタップ時のアクション
                            //timerHandlerをアンラップしてunwrappedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                //もしタイマーが実行中だったら停止
                                if unwrapedTimerHandler.isValid == true {
                                    //タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }


                        } label: {
                            Text("ストップ")
                            //文字サイズ
                                .font(.title)
                            //文字色を白に
                                .foregroundColor(Color.white)
                            //幅高さを140に
                                .frame(width: 140, height: 140)
                            //背景を設定
                                .background(Color("stopColor"))
                            //円形にくり抜く
                                .clipShape(Circle())
                        }
                    }
                }//VStack
            }//ZStack
            //画面が表示されるときに実行
            .onAppear {
                //カウント（経過時間）の変数を初期化
                count = 0
            } // .onAppear
            //ナビゲーションにボタンを追加
            .toolbar {
                //ナビゲーションバーの右下にボタン追加
                ToolbarItem(placement: .navigationBarTrailing) {
                    //ナビゲーション遷移
                    NavigationLink {
                        SettingView()
                    } label: {
                        //テキスト表示
                        Text("秒数設定")
                    }//NavigationLink
                }//ToolbarItem
            }//.toolbar

            //状態変数showAlertがtrueになったときに実行
            .alert("終了", isPresented: $showAlert) {
                Button("OK") {
                    //OKをタップしたときに実行
                    print("OKタップされました")
                }
            } message: {
                Text("タイマー終了時間です")
            }//.alert
        }//NavigationStack
    }//body

    //1秒ごとに実行されてカウントダウンする
    func countDownTimer() {
        //count（経過時間）に+1していく
        count += 1

        //残り時間が0以下の時、タイマーを止める
        if timerValue - count <= 0 {
            //タイマー停止
            timerHandler?.invalidate()
            //アラート表示
            showAlert = true
        }
    }//countDownTimer()ここまで

    //タイマーをカウントダウン開始する関数
    func startTimer() {
        //timerHandlerをアンラップしてunwrappedTimerHandlerに代入
        if let unwrappedTimerHandler = timerHandler {
            //もしタイマーが実行中だったらスタートしない
            if unwrappedTimerHandler.isValid == true {
                //何も処理しない
                return
            }
        }

        //残り時間が0以下の時、count（経過時間）を0に初期化
        if timerValue - count <= 0 {
            //countを0に
            count = 0
        }

        //タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            //タイマー実行時に呼び出される
            //1秒ごとに実行されてカウントダウンする関数を実行
            countDownTimer()
        }
    }//startTimer
}//ContentView

#Preview {
    ContentView()
}
