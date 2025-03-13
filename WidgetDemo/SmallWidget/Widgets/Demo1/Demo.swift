//
//  Demo.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/3/12.
//

import WidgetKit
import SwiftUI

// 时间线刷新策略控制
struct Provider: IntentTimelineProvider {
    
    // 窗口首次展示的时候，展示默认数据
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    // 添加组件时的预览数据，在桌面滑动选择的时候展示数据
    func getSnapshot(for configuration: DemoIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    // 时间线刷新策略控制逻辑
    func getTimeline(for configuration: DemoIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    // 默认带了一个日期参数
    let date: Date
}

struct DemoEntryView : View {
    // 组件数据
    var entry: Provider.Entry
    
    // 这个 body 中就是自己需要实现的组件布局
    var body: some View {
        Text(entry.date, style: .time)
    }
}

// 小组件入口
struct DemoWidget: Widget {
    // 小组件的唯一ID
    let kind: String = "DemoWidget"
    
    var body: some WidgetConfiguration {
        // 创建时不勾选 “Include Configuration Intent”，这里使用 StaticConfiguration
        IntentConfiguration(kind: kind, intent: DemoIntent.self, provider: Provider()) { entry in
            DemoEntryView(entry: entry)
                .widgetBackground(Color.systemWhite)
        }
        .supportedFamilies([.systemSmall, .systemMedium])  // 配置该组件支持的尺寸，如果不配置，默认是大中小都支持
        .configurationDisplayName("组件标题")   // 在添加组件预览界面显示
        .description("组件描述")                 
    }
}

// 调试预览
struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        DemoEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

