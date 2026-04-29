import SwiftUI

@main
struct FamilyOSApp: App {
    @StateObject private var store = FamilyOSStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
