import Foundation
import SwiftUI

struct Achievement: Identifiable, Codable {
    var id = UUID()
    var icon: String
    var title: String
    var description: String
    var isUnlocked: Bool
}

class UserStatsViewModel: ObservableObject {
    @Published var exercisesCompleted: Int = 0
    @Published var achievements: [Achievement] = []

    private var username: String = ""

    init(username: String = "") {
        self.username = username
        loadStats()
    }

    func loadStats() {
        let key = "\(username)_stats"
        if let data = UserDefaults.standard.data(forKey: key),
           let stats = try? JSONDecoder().decode(UserStatsData.self, from: data) {
            exercisesCompleted = stats.exercisesCompleted
            achievements = stats.achievements
        } else {
            achievements = defaultAchievements()
        }
    }

    func saveStats() {
        let key = "\(username)_stats"
        let stats = UserStatsData(
            exercisesCompleted: exercisesCompleted,
            achievements: achievements
        )
        if let data = try? JSONEncoder().encode(stats) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func resetStats() {
        exercisesCompleted = 0
        achievements = defaultAchievements()
        saveStats()
    }

    func defaultAchievements() -> [Achievement] {
        return [
            Achievement(icon: "star.fill", title: "First Steps", description: "Complete your first exercise session.", isUnlocked: false),
            Achievement(icon: "bolt.fill", title: "Power Surge", description: "Complete 10 exercise sessions.", isUnlocked: false)
        ]
    }

    func updateStatsForExercise() {
        exercisesCompleted += 1
        updateAchievements()
        saveStats()
    }

    func updateAchievements() {
        // Check and unlock achievements based on stats
        for i in 0..<achievements.count {
            if !achievements[i].isUnlocked {
                switch i {
                case 0: // First Steps
                    if exercisesCompleted >= 1 {
                        achievements[i].isUnlocked = true
                    }
                case 1: // Power Surge
                    if exercisesCompleted >= 10 {
                        achievements[i].isUnlocked = true
                    }
                default:
                    break
                }
            }
        }
    }
}

struct UserStatsData: Codable {
    var exercisesCompleted: Int
    var achievements: [Achievement]
    
    enum CodingKeys: String, CodingKey {
        case exercisesCompleted
        case achievements
    }
}
