import SwiftUI

@main
struct BREATH3App: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @StateObject var userStats = UserStatsViewModel()

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainView()
                    .environmentObject(userStats)
            } else {
                OnboardingView()
            }
        }
    }
}
