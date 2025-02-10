//
//  DynamicIntent+Intent.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/8.
//
import AppIntents
import WidgetKit


struct ConfigurationAppIntent: WidgetConfigurationIntent {
    
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget.." }
    
    @IntentParameter(title: "设备", description: "选择门锁")
    var device: DeviceEntity?
    
    @Parameter(title: "型号", default: .lock)
    var kind: DeviceKind
    
    init(device: DeviceEntity? = nil) {
        self.device = device
    }
    
    init() {}
    
    static var parameterSummary: some ParameterSummary {
        Summary {
            \.$device
            \.$kind
        }
    }
    
//    func perform() async throws -> some IntentResult {
//        print("perform")
//        return .result()
//    }
}

enum DeviceKind: String, AppEnum {
    case lock, ammeter, water, hotWater
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "DeviceKind"
    static var caseDisplayRepresentations: [DeviceKind : DisplayRepresentation] = [
        .lock: "门锁",
        .ammeter: "电表",
        .water: "冷水表",
        .hotWater: "热水表"
    ]
    
    var displayRepresentation: DisplayRepresentation {
        .init(title: "mac", subtitle: "remark")
    }
}

struct DeviceEntity: AppEntity, Identifiable, Hashable {
    
    var id: Device.ID
    var mac: String
    var remark: String
    
    
    init(id: Device.ID, mac: String, remark: String) {
        self.id = id
        self.mac = mac
        self.remark = remark
    }
    
    init(from device: Device) {
        id = device.id
        mac = device.mac
        remark = device.remark
    }
    
    var displayRepresentation: DisplayRepresentation {
        .init(title: "\(mac)", subtitle: "\(remark)")
    }
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "device")
    static var defaultQuery = DeviceEntityQuery()
}

struct DeviceEntityQuery: EntityQuery, Sendable {
    /// 允许通过 ID 获取实体
    func entities(for identifiers: [DeviceEntity.ID]) async throws -> [DeviceEntity] {
        Device.getAll()
            .filter { identifiers.contains($0.id) }
            .map(DeviceEntity.init)
    }
    
    /// 允许搜索
    func entities(matching string: String) async throws -> [DeviceEntity] {
        let allItems = try await suggestedEntities()
        return allItems.filter { $0.mac.lowercased().contains(string.lowercased()) }
    }
    
    func suggestedEntities() async throws -> [DeviceEntity] {
        Device.getAll().map(DeviceEntity.init)
    }
    
//    func defaultResult() async -> DeviceEntity? {
//        try? await suggestedEntities().first
//    }
}

extension DeviceEntityQuery: EnumerableEntityQuery {
    func allEntities() async throws -> [DeviceEntity] {
        Device.getAll().map(DeviceEntity.init)
    }
}


struct Device: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString
    var mac: String
    var remark: String
}

extension Device {
    static func getAll() -> [Self] {
        //        let key = UserDefaultKey.persons
        //        guard let persons: [Self] = UserDefaults.appGroup.getArray(forKey: key) else {
        //            let persons: [Self] = .defaultDevices
        //            UserDefaults.appGroup.setArray(persons, forKey: key)
        //            return persons
        //        }
        //        return persons
        
        let persons: [Self] = .defaultDevices
        
        return persons
    }
}

extension Device {
    init?(identifier: String) {
        if let device = Self.getAll().first(where: { $0.id == identifier }) {
            self = device
        } else {
            return nil
        }
    }
}

extension [Device] {
    static let defaultDevices: Self = [
        .init(
            mac: "D7:3A:19:35:3A:F5",
            remark: "D7"
        ),
        .init(
            mac: "E9:35:17:33:D9:F7",
            remark: "E9"
        ),
    ]
}

