//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/21.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

/*
 视图控制器的公共父类
 用来封装一些共有的代码
 */
class BaseViewController: UIViewController {

    //导航上面添加按钮
    func addNavBtn(imageName: String, target: AnyObject?, action:Selector, isLeft: Bool) {
        let btn = UIButton.createBtn(nil, bgImageName: imageName, highlightImageName: nil, selectImageName: nil, target: target, action: action)

        btn.frame = CGRectMake(0, 0, 30, 45)

        let barBtn = UIBarButtonItem(customView: btn)

        if isLeft {
            //左边按钮
            navigationItem.leftBarButtonItem = barBtn
        }else {
            //右边按钮
            navigationItem.rightBarButtonItem = barBtn
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置背景颜色
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
