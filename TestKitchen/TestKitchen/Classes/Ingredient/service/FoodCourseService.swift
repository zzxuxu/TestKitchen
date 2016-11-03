//
//  FoodCourseService.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/11/3.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class FoodCourseService: NSObject {

    class func handleFoodCourse(courseId:String, onViewController vc: UIViewController) {

        //跳转到食材课程分页的界面
        let ctrl = FoodCourseController()
        ctrl.courseId = courseId

        vc.navigationController?.pushViewController(ctrl, animated: true)

    }

}
