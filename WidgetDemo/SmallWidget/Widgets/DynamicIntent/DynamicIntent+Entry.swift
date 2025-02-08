//
//  DynamicIntent+Entry.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/8.
//

import WidgetKit

struct DynamicEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

extension DynamicEntry {
    static var empty: Self {
        .init(date: .now, configuration: ConfigurationAppIntent())
    }
    
    static var placeholder: Self {
        let intent = ConfigurationAppIntent()
        intent.device = DeviceEntity(id: UUID().uuidString, mac: "D7:3A:19:35:3A:F5", remark: "示例")
        return .init(date: .now, configuration: intent)
    }
}
