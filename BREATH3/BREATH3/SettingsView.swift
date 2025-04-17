import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section(header: Text("App Information").foregroundColor(.primary)) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.1 ALPHA")
                }
                Text("Dreamflow is in early Alpha stages. We're working hard to improve your experience! If you have any feedback, feel free to email at prctudor@gmail.com")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
        .background(Color(UIColor.systemBackground))
    }
}
