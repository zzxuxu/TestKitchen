//
//  IngreTopicCell.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/11/1.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngreTopicCell: UITableViewCell {

    @IBOutlet weak var topicImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var descLabel: UILabel!

    //点击事件
    var jumpClosure: IngreJumpClosure?

    //显示数据
    var cellArray: Array<IngreRecommendwidgetData>? {
        didSet {
            showData()
        }
    }

    func showData() {

        //图片
        if cellArray?.count > 0 {
            let imageData = cellArray![0]
            if imageData.type == "image" {
                let url = NSURL(string: imageData.content!)
                topicImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            }
        }

        //标题
        if cellArray?.count > 1 {
            let titleData = cellArray![1]
            if titleData.type == "text" {
                nameLabel.text = titleData.content
            }
        }

        //描述文字
        if cellArray?.count > 2 {
            let descData = cellArray![2]
            if descData.type == "text" {
                descLabel.text = descData.content
            }
        }

    }

    class func createTopicCellFor(tableView:UITableView, atIndexPath indexPath: NSIndexPath, cellArray: Array<IngreRecommendwidgetData>?) -> IngreTopicCell {
        let cellId = "ingreTopicCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreTopicCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreTopicCell", owner: nil, options: nil).last as? IngreTopicCell
        }
        //显示数据
        cell?.cellArray = cellArray
        return cell!
    }

    func tapAction() {

        if cellArray?.count > 0 {
            let imageData = cellArray![0]
            if imageData.link != nil && jumpClosure != nil {
                jumpClosure!(imageData.link!)
            }
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()

         //点击事件
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
