//
//  SmallWidgetBundle.swift
//  SmallWidget
//
//  Created by run on 2025/2/7.
//

import WidgetKit
import SwiftUI

@main
struct SmallWidgetBundle: WidgetBundle {
    var body: some Widget {
        DynamicIntentWidget()
        
        if #available(iOS 18.0, *) {
            SmallWidgetControl()
        }
    }
}
