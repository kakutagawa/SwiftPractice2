//
//  OkashiData.swift
//  MyOkashi1
//
//  Created by 芥川浩平 on 2023/10/25.
//

import Foundation

//お菓子データ検索用クラス
class OkashiData: ObservableObject {
    //WebAPI検索用メソッド　第一引数：keyword 検索したいワード
    func searchOkashi(keyword: String) {
        //デバッグエリアに出力
        print("searchOkashiメソッドで受け取った値：\(keyword)")

        //Taskは非同期で処理を実行できる
        Task {
            //ここから先は非同期で処理される
            //非同期でお菓子を検索する
            await search(keyword: keyword)
        }//Task
    }//searchOkashi

    //非同期でお菓子データを取得
    private func search(keyword: String) async {
        //デバッグエリアに出力
        print("searchメソッドで受け取った値：\(keyword)")
    }//search
}//OkashiData
