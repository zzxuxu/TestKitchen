//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/21.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.yellowColor()

        //滚动视图或者子视图放在导航下面会自动加一个上面的间距，我们要取消这个间距
        automaticallyAdjustsScrollViewInsets = false
        downloadRecommendData()
    }

    //下载首页的推荐数据
    func downloadRecommendData(){
        //methodName=SceneHome&token=&user_id=&version=4.5

        let params = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]

        let downloader = KTCDownload()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: params)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:KTCDownloader代理方法
extension IngredientViewController:KTCDownloadDelegate {
    //下载失败
    func downloader(downloader: KTCDownload, didFailWithError error: NSError) {
        print(error)
    }

    //下载成功
    func downloader(downloader: KTCDownload, didFinishWithData data: NSData?) {
//        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(str!)

        if let tmpData = data {
            //1.json解析
            let recommendModel = IngreRecommend.parseData(tmpData)
            //2.显示UI
            let recommendView = IngreRecommendView(frame: CGRectZero)
            recommendView.model = recommendModel
            view.addSubview(recommendView)

            //约束
            recommendView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            })

        }
    }

}














