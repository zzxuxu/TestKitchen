//
//  IngreService.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/11/3.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import UIKit

class IngreService: NSObject {

    class func handleEvent(urlString :String, onViewController vc:UIViewController) {

        if urlString .hasPrefix("app://food_course_series") {
            //食材课程分集显示

            let array = urlString.componentsSeparatedByString("#")
            if array.count > 1 {
                let courseId = array[1]

                FoodCourseService.handleFoodCourse(courseId, onViewController: vc)
            }

        }

    }

}
