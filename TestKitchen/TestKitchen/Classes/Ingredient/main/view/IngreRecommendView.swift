//
//  IngreRecommendView.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/25.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

//定义食材首页widget列表的类型
public enum IngreWidgetType:Int {
    case GuessYouLike = 1 // 猜你喜欢
    case RedPacket = 2 //红包入口
    case TodayNew = 5 //今日新品
}

class IngreRecommendView: UIView {

    var jumpClosure: IngreJumpClosure?

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
        var section = 1

        if model?.data?.widgetList?.count > 0 {

            section += (model?.data?.widgetList?.count)!

        }

        return section
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //banner广告的section显示一行
        var row = 0

        if section == 0 {
            //广告
            row = 1
        }else{

            //获取list对象
            let listModel = model?.data?.widgetList![section-1]

            if (listModel?.widget_type?.integerValue)! == IngreWidgetType.GuessYouLike.rawValue || (listModel?.widget_type?.integerValue)! == IngreWidgetType.RedPacket.rawValue || (listModel?.widget_type?.integerValue)! == IngreWidgetType.TodayNew.rawValue{
                //猜你喜欢
                //红包入口
                //今日新品
                row = 1
            }

        }

        return row
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //banner广告高度为140
        var height:CGFloat = 0

        if indexPath.section == 0 {
            //banner广告
            height = 140
        }else{

            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢
                height = 70
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.RedPacket.rawValue {
                //红包入口
                height = 75
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue {
                //今日新品
                height = 280
            }

        }

        return height
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


//        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as? IngreBannerCell

        if indexPath.section == 0 {
            //banner广告
             let cell = IngreBannerCell.createBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: (model?.data!.banner)!)

            //
            cell.jumpClosure = jumpClosure

            return cell
        }else{

            let listModel = model?.data?.widgetList![indexPath.section-1]

            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢
                let cell = IngreLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.RedPacket.rawValue {
                //猜你喜欢
                let cell = IngreRedPacketCell.createRedPacketCellFor(tableView, atindexPath: indexPath, listModel: listModel!)
                //点击事件
                cell.jumpClosure = jumpClosure

                return cell

            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue {
                //猜你喜欢
                let cell = IngreTodayCell.createTodayCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                //点击事件
                cell.jumpClosure = jumpClosure

                return cell
                
            }

        }

        return UITableViewCell()

    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section > 0 {

            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢分组的header
                let likeHeaderView = IngreLikeHeaderView(frame: CGRectMake(0,0,tbView!.bounds.width,44))
                return likeHeaderView
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue {
                //猜你今日新品的header
                let headView = IngreHeaderView(frame: CGRectMake(0,0,kScreenW,54))
                headView.configText((listModel?.title)!)

            }
        }

        return nil
    }

    //设置header的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        var height:CGFloat = 0
        if section > 0 {

            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                height = 44
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue {
                height = 54
            }
        }

        return height
    }
}















