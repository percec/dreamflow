import SwiftUI

struct AchievementsDetailView: View {
    var achievements: [Achievement]
    
    var body: some View {
        List(achievements) { achievement in
            HStack {
                Image(systemName: achievement.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(achievement.isUnlocked ? .primary : .gray)
                VStack(alignment: .leading) {
                    Text(achievement.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(achievement.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 5)
        }
        .navigationTitle("Achievements")
    }
}
