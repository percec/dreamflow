import SwiftUI

struct RankDetail: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

struct RankDetailsView: View {
    let rankDetails = [
        RankDetail(title: "Beginner", description: "0 - 20% experience. Start your journey."),
        RankDetail(title: "Novice", description: "21 - 40% experience. Keep going."),
        RankDetail(title: "Intermediate", description: "41 - 60% experience. Making progress."),
        RankDetail(title: "Advanced", description: "61 - 80% experience. Nearly there."),
        RankDetail(title: "Zen Master", description: "81 - 100% experience. True mastery.")
    ]
    
    var body: some View {
        List(rankDetails) { detail in
            VStack(alignment: .leading) {
                Text(detail.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(detail.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 5)
        }
        .navigationTitle("Rank Details")
    }
}
