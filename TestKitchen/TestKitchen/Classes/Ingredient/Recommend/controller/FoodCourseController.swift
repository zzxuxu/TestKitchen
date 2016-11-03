//
//  FoodCourseController.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/11/3.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class FoodCourseController: BaseViewController {

    //id
    var courseId: String?

    //表格
    var tbView: UITableView?

    //详情的数据
    private var detailData: FoodCourseDetail?

    //创建表格
    func createTableView() {
        automaticallyAdjustsScrollViewInsets = false

        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //下载详情的数据
        downloadDetailData()

    }

    //下载详情的数据
    func downloadDetailData() {
        //methodName=CourseSeriesView&series_id=22&token=&user_id=&version=4.32

        let params = ["methodName":"CourseSeriesView","series_id":"\(courseId!)"]

        let downloader = KTCDownload()
        downloader.delegate = self
        downloader.downloadType = .IngreFoodCourseDetail
        downloader.postWithUrl(kHostUrl, params: params)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//MARK: KTCDownload代理
extension FoodCourseController: KTCDownloadDelegate {

    func downloader(downloader: KTCDownload, didFailWithError error: NSError) {
        print(error)
    }

    func downloader(downloader: KTCDownload, didFinishWithData data: NSData?) {

        if downloader.downloadType == .IngreFoodCourseDetail {
            //详情

//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str!)

            if let tmpData = data {
                detailData = FoodCourseDetail.parseData(tmpData)
                //显示数据
            }

        }else if downloader.downloadType == .IngreFoodCourseComment {
            //评论
        }

    }

}


//MARK:UITableView的代理
extension FoodCourseController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //详情
            return 3
        }else if section == 1 {
            //评论
            return 0
        }

        return 0
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}





