//
//  Extension.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/8.
//

import SwiftUI

extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        // 如果是 iOS 17，则使用 containerBackground
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}


extension WidgetConfiguration {
    func disableContentMarginsIfNeeded() -> some WidgetConfiguration {
        if #available(iOSApplicationExtension 17.0, *) {
            return self.contentMarginsDisabled()
        } else {
            return self
        }
    }
}
