//
//  DynamicIntentWidget.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/8.
//

import WidgetKit
import SwiftUI

struct DynamicIntentWidget: Widget {
    let kind: String = "DynamicIntentWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: DynamicIntentProvider()) { entry in
            RunnerWidgetEntryView(entry: entry)
                .widgetBackground(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: 0x28D776), Color(hex: 0x51EDAE)]),
                        startPoint:.top,
                        endPoint:.bottom
                    )
                )
        }
        .configurationDisplayName("智能门锁")
        .description("将门锁放到桌面，快速开锁")
        .supportedFamilies([.systemSmall])
        .disableContentMarginsIfNeeded()
    }
}

#Preview(as: .systemSmall) {
    DynamicIntentWidget()
} timeline: {
    DynamicEntry.empty
    DynamicEntry.placeholder
}

