//
//  IngredientViewController.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/21.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {

    //滚动视图
    private var scrollView: UIScrollView?

    //推荐视图
    private var recommendView: IngreRecommendView?

    //食材视图
    private var materiaView: IngreMaterrialView?

    //分类视图
    private var categoryView: IngreMaterrialView?

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.yellowColor()

        //滚动视图或者子视图放在导航下面会自动加一个上面的间距，我们要取消这个间距
        automaticallyAdjustsScrollViewInsets = false

        //导航
        createNav()

        createHomePage()

        downloadRecommendData()
    }

    //创建首页视图
    func createHomePage() {

        scrollView = UIScrollView()
        scrollView!.pagingEnabled = true
        view.addSubview(scrollView!)

        scrollView!.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }

        //容器视图
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView!)
            make.height.equalTo(scrollView!)
        }

        //上一次的子视图
//        let lastView: UIView? = nil

        //添加子视图
        //1.推荐视图
        recommendView = IngreRecommendView()
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.left.equalTo(containerView)
            make.width.equalTo(kScreenW)
        })

        //2.食材视图
        materiaView = IngreMaterrialView()
        materiaView?.backgroundColor = UIColor.blueColor()
        containerView.addSubview(materiaView!)
        materiaView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenW)
            make.left.equalTo((recommendView?.snp_right)!)
        })

        //3.分类视图
        categoryView = IngreMaterrialView()
        categoryView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenW)
            make.left.equalTo((materiaView?.snp_right)!)
        })

        //修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }

    }

    //创建导航
    func createNav() {

        //扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)

        //搜索
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)

        //选择控件
        let frame = CGRectMake(80, 0, kScreenW-80*2, 44)
        let segCtrl = KTCSegCtrl(frame: frame, titleArray: ["推荐","食材","分类"])
        segCtrl.delegate = self
        navigationItem.titleView = segCtrl

    }

    //扫一扫
    func scanAction() {
        print("扫一扫")
    }

    //搜索
    func searchAction() {
        print("搜索")
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
//            let recommendView = IngreRecommendView(frame: CGRectZero)
            recommendView!.model = recommendModel
//            view.addSubview(recommendView)

            //3.点击食材的推荐页面的某一部分，跳转到后面的界面
            recommendView!.jumpClosure = { jumpUrl in
                print(jumpUrl)
            }

            //约束
//            recommendView.snp_makeConstraints(closure: { (make) in
//                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
//            })

        }
    }

}


//MARK: KTCSegCtrl代理
extension IngredientViewController:KTCSegCtrlDelegate {
    func segCtrl(segCtrl: KTCSegCtrl, didClickBtnAtIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(CGFloat(index)*kScreenW, 0), animated: true)
    }
}











