//
//  IngreLikeHeaderView.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/26.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngreLikeHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        //设置背景颜色
        backgroundColor = UIColor.lightGrayColor()

        //文本输入框
        let textField = UITextField(frame: CGRectMake(20,7,bounds.width-20*2,30))
        textField.placeholder = "输入菜名或食材搜索"
        textField.borderStyle = .RoundedRect
        addSubview(textField)

        //设置左边的搜索图片
        let image = UIImage(named: "search1")
        let imageView = UIImageView(image: image)

        textField.leftView = imageView
        textField.leftViewMode = .Always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
