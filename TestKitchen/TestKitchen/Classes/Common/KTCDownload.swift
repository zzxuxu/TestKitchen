//
//  KTCDownload.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/24.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit
import Alamofire

protocol KTCDownloadDelegate:NSObjectProtocol {
    //下载失败
    func downloader(downloader:KTCDownload,didFailWithError error:NSError)

    //下载成功
    func downloader(downloader:KTCDownload,didFinishWithData data:NSData?)

}

enum KTCDownloadType: Int {
    case Normal = 0
    case IngreRecommend     //首页食材的推荐
    case IngreMaterial      //首页食材的食材
    case IngreCategory      //首页食材的分类

    case IngreFoodCourseDetail  //食材课程的详情
    case IngreFoodCourseComment //食材课程的评论
}

class KTCDownload: NSObject {

    //代理属性
    weak var delegate:KTCDownloadDelegate?

    //下载的类型
    var downloadType:KTCDownloadType = .Normal

    //post请求数据
    func postWithUrl(urlString:String,params: Dictionary<String,AnyObject>){

        var tmpDict = NSDictionary(dictionary: params) as! Dictionary<String,AnyObject>

        //设置所有接口的公共参数
        tmpDict["token"] = ""
        tmpDict["user_id"] = ""
        tmpDict["version"] = "4.5"

        //token=&user_id=&version=4.32

        Alamofire.request(.POST, urlString, parameters: tmpDict, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
            case .Failure(let error):
                //下载失败
                self.delegate?.downloader(self, didFailWithError: error)

            case .Success:
                //下载成功
                self.delegate?.downloader(self, didFinishWithData: response.data)
            }
            
        }
    }
}
