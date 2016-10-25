//
//  IngreRecommendView.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/25.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngreRecommendView: UIView {

    //数据
    var model:IngreRecommend? {
        didSet {
            //set方法调用之后会调用这里的方法
            tbView?.reloadData()
        }
    }

    //表格
    private var tbView: UITableView?

    //重新实现初始化方法
    override init(frame: CGRect) {

        super.init(frame: frame)

        //创建表格视图
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
//        tbView?.backgroundColor = UIColor.blueColor()

//        let nib = UINib(nibName: "IngreBannerCell", bundle: nil)
//        tbView?.registerNib(nib, forCellReuseIdentifier: "ingreBannerCellId")
        addSubview(tbView!)

        //约束
        tbView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalToSuperview()
        })

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK:UITableView代理
extension IngreRecommendView:UITableViewDelegate,UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //banner广告部分显示一个分组
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //banner广告的section显示一行
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //banner广告高度为140
        return 140
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


//        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as? IngreBannerCell

        let cell = IngreBannerCell.createBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: (model?.data!.banner)!)

        return cell
    }


}















