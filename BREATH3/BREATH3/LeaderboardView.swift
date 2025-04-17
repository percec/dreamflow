import SwiftUI

struct LeaderboardEntry: Identifiable, Codable {
    var id = UUID()
    var username: String
    var score: Int
}

class LeaderboardManager: ObservableObject {
    @Published var entries: [LeaderboardEntry] = []
    
    init() {
        // Load your leaderboard data here.
        entries = []
    }
    
    func addEntry(username: String, score: Int) {
        let newEntry = LeaderboardEntry(username: username, score: score)
        entries.append(newEntry)
        entries.sort { $0.score > $1.score }
    }
}

struct LeaderboardView: View {
    @StateObject var leaderboardManager = LeaderboardManager()
    
    var body: some View {
        VStack {
            if leaderboardManager.entries.isEmpty {
                Text("No leaderboard data available.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List(leaderboardManager.entries) { entry in
                    HStack {
                        Text(entry.username)
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(entry.score)")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Global Leaderboard")
        .background(Color(UIColor.systemBackground))
    }
}
