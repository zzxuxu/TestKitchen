//
//  IngreTodayCell.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/27.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngreTodayCell: UITableViewCell {

    var jumpClosure:IngreJumpClosure?

    //数据
    var listModel:IngreRecommendwidgetList? {
        didSet {
            showData()
        }
    }

    func showData() {

        if listModel?.widget_data?.count>0 {
            for i in 0..<3 {

                //图片
                //i:     0 1 2
                //image: 0 4 8
                //video: 1 5 9
                //text:  2 6 10
                //text:  3 7 11

                //图片
                if i*4 < listModel?.widget_data?.count {
                    let imageData = listModel?.widget_data![i*4]
                    if imageData?.type == "image" {
                        //获取图片视图
                        let tmpView = contentView.viewWithTag(100+i)
                        if tmpView?.isKindOfClass(UIImageView) == true {
                            let imageView = tmpView as! UIImageView

                            let url = NSURL(string: (imageData?.content)!)
                            imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        }
                    }
                }

                //标题
                if i*4+2 < listModel?.widget_data?.count {
                    let textData = listModel?.widget_data![i*4+2]
                    if textData?.type == "text" {
                        let tmpView = contentView.viewWithTag(200+i)
                        if tmpView?.isKindOfClass(UILabel) == true {
                            let titleLabel = tmpView as! UILabel
                            titleLabel.text = textData?.content
                        }
                    }
                }

                //描述
                if i*4+3 < listModel?.widget_data?.count {
                    let descData = listModel?.widget_data![i*4+3]
                    if descData?.type == "text" {

                        //获取子视图
                        let tmpView = contentView.viewWithTag(300+i)
                        if tmpView?.isKindOfClass(UILabel) == true {
                            let descLabel = tmpView as! UILabel
                            descLabel.text = descData?.content
                        }
                    }
                }

            }
        }
    }

    //点击进入详情
    @IBAction func clickDish(sender: UIButton) {

        let index = sender.tag-400
        if index*4 < listModel?.widget_data?.count {
            let imageData = listModel?.widget_data![index*4]
            if imageData?.type == "image" {
                if jumpClosure != nil && imageData?.link != nil {
                    jumpClosure!((imageData?.link)!)
                }
            }
        }

    }

    //点击播放视频
    @IBAction func playAction(sender: UIButton) {

        let index = sender.tag-500

        if index*4+1 < listModel?.widget_data?.count {
            let videoData = listModel?.widget_data![index*4+1]
            if videoData?.type == "video" {
                if jumpClosure != nil && videoData?.content != nil {
                    jumpClosure!((videoData?.content)!)
                }
            }
        }
    }

    //创建cell的方法
    class func createTodayCellFor(tableView:UITableView, atIndexPath indexPath:NSIndexPath, listModel:IngreRecommendwidgetList?) -> IngreTodayCell {
        let cellId = "ingreTodayCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreTodayCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreTodayCell", owner: nil, options: nil).last as? IngreTodayCell
        }

        cell?.listModel = listModel

        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
