//
//  PeepPeepApp.swift
//  PeepPeep
//
//  Created by Ha Jong Myeong on 2023/07/12.
//

import SwiftUI

@main
struct PeepPeepApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
//앱그룹을 이용해 유저디폴트를 익스텐션으로 전달할 때 사용하는 코드
extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.7C76V3X7AB.com.restco.PeepPeep"
        return UserDefaults(suiteName: appGroupId)!
    }
}
