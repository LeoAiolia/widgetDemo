//
//  DynamicIntent+EntryView.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/8.
//

import SwiftUI

struct RunnerWidgetEntryView : View {
    let entry: DynamicEntry
    
    var body: some View {
        
        VStack {
            
            
            if let mac = entry.configuration.device?.mac, !mac.isEmpty {
                VStack(spacing: 6.0) {
                    Text("点击开锁")
                        .font(.system(size: 14.0))
                    
                    Text("当前门锁地址")
                        .font(.system(size: 14.0))
                    
                    Text(mac)
                        .font(.system(size: 14.0))
                }
                
            } else {
                Text("请输入门锁地址")
            }
        }
        .widgetURL(URL(string: getURLString()))
    }
    
    func getURLString() -> String {
        var mac = entry.configuration.device?.mac ?? ""
        mac = mac.replacingOccurrences(of: ":", with: "").lowercased()
        if mac.count != 12 {
            return "https://c.yuxiaor.com/nfc"
        }
        
        return "https://c.yuxiaor.com/nfc?id=\(mac)"
    }
}

