//
//  DynamicIntent+Provider.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/8.
//

import WidgetKit
import SwiftUI

struct DynamicIntentProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> DynamicEntry {
        .placeholder
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> DynamicEntry {
        DynamicEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<DynamicEntry> {
        let entry = DynamicEntry(date: .now, configuration: configuration)
        return Timeline(entries: [entry], policy: .never)
    }
}
