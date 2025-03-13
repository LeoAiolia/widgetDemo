//
//  IntentHandler.swift
//  CarControl
//
//  Created by run on 2025/3/12.
//
import Intents

enum CarControlType: String, CaseIterable {
    case lock
    case findCar
    case trunk
    case window
    case airCondition
    case ventilate
    case skylight
}

extension CarControlType {
    var name: String {
        switch self {
        case .lock:
            return "车锁"
        case .findCar:
            return "寻车"
        case .trunk:
            return "后备箱"
        case .window:
            return "车窗"
        case .airCondition:
            return "空调"
        case .ventilate:
            return "透气"
        case .skylight:
            return "天窗"
        }
    }
}

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}


extension IntentHandler: DemoIntentHandling {
    
    func provideCarControlsOptionsCollection(for intent: DemoIntent, searchTerm: String?) async throws -> INObjectCollection<CarControl> {
        var carControlTypes = CarControlType
            .allCases
            .filter { carControlType in
                intent.identifier != carControlType.rawValue
            } // 过滤掉编辑页面已经存在的车控功能
        
        // 匹配搜索关键字
        if let searchTerm {
            carControlTypes = carControlTypes.filter { $0.name.contains(searchTerm) }
        }
        
        let carControls = carControlTypes.map { CarControl(identifier: $0.rawValue, display: $0.name) }
        return INObjectCollection(items: carControls)
    }
    
    /// 提供默认4个车控功能（小组件生命周期内只会执行一次）
    func defaultCarControls(for intent: DemoIntent) -> [CarControl]? {
        return CarControlType
            .allCases
            .prefix(4)
            .map { CarControl(identifier: $0.rawValue, display: $0.name) }
    }
}

//extension IntentHandler: WidgetConfigurationIntentHandling {
//    
//}
