//
//  IngreLikeCell.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/25.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngreLikeCell: UITableViewCell {

    var jumpClosure: IngreJumpClosure?

    //数据
    var listModel:IngreRecommendwidgetList?{
        didSet {
            showData()
        }
    }

    //显示数据
    private func showData() {
        if listModel?.widget_data?.count > 1 {
            for var i in 0..<(listModel?.widget_data?.count)!-1 {

                //图片
                //tag值200 201 202 203
                let imageData = listModel?.widget_data![i]
                if imageData?.type == "image" {
                    let imageTag = 200+i/2

                    let imageView = contentView.viewWithTag(imageTag)

                    if imageView?.isKindOfClass(UIImageView) == true {

                        let tmpImageView = imageView as! UIImageView


                        let url = NSURL(string: (imageData?.content)!)

                        tmpImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }

                //文字
//                if i+1 < listModel?.widget_data![i+1]
                let textData = listModel?.widget_data![i+1]
                if textData?.type == "text" {
                    let label = contentView.viewWithTag(300+i/2)
                    if label?.isKindOfClass(UILabel) == true {
                        let tmpLabel = label as! UILabel
                        tmpLabel.text = textData?.content
                    }
                }

                i += 1
            }
        }
    }

    //创建cell的方法
    class func createLikeCellFor(tableView:UITableView, atIndexPath indexPath:NSIndexPath, listModel:IngreRecommendwidgetList?) -> IngreLikeCell {

        let cellId = "ingreLikeCellId"

        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreLikeCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreLikeCell", owner: nil, options: nil).last as? IngreLikeCell
        }

        //显示数据
        cell?.listModel = listModel
        return cell!
    }

    @IBAction func clickBtn(sender: UIButton) {

        let index = sender.tag - 100

        //index: 0 1 2 3
        //序号：  0 2 4 6

        if index*2 < listModel?.widget_data?.count{
            let data = listModel?.widget_data![index*2]

            if data?.link != nil && jumpClosure != nil {
                jumpClosure!((data?.link)!)
            }
        }

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
