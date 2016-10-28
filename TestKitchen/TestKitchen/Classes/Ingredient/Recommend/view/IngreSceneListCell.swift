//
//  IngreSceneListCell.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/28.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngreSceneListCell: UITableViewCell {

    //点击事件
    var jumpClosure:IngreJumpClosure?

    //数据
    var listModel: IngreRecommendwidgetList? {
        didSet {
            config((listModel?.title)!)
        }
    }

    @IBOutlet weak var titleLabel: UILabel!

    func config(text: String) {
        titleLabel.text = text

    }

    class func createSceneListCellFor(tableView:UITableView, atIndexPath indexPath:NSIndexPath, listmodel: IngreRecommendwidgetList?) -> IngreSceneListCell {
        let cellId = "ingreSceneListCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreSceneListCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreSceneListCell", owner: nil, options: nil).last as? IngreSceneListCell
        }
        //显示数据
        cell?.listModel = listmodel
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        //点击手势
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)

    }

    func tapAction() {
        if jumpClosure != nil && listModel?.title_link != nil {
            jumpClosure!((listModel?.title_link)!)
        }
    }



    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
