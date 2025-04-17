import SwiftUI

struct MainView: View {
    @EnvironmentObject var userStats: UserStatsViewModel
    @State private var selectedTab: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // Flower Animation
                FlowerAnimationView()
                    .frame(width: 200, height: 200)
                    .opacity(selectedTab == 0 ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: selectedTab)

                // Coming Soon Animation for Guided Meditation
                if selectedTab == 1 {
                    VStack {
                        FlowerAnimationView()
                            .frame(width: 100, height: 100)
                        Text("Guided Meditation")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.primary)
                        Text("Coming Soon!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .transition(.opacity)
                }

                Spacer()

                // Tab Slider
                Picker("", selection: $selectedTab) {
                    Text("Breathing Exercises").tag(0)
                    Text("Guided Meditation").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)

                // Action Button
                NavigationLink(destination: ExerciseSelectionView().environmentObject(userStats)) {
                    Text("Start Breathing Exercise")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .opacity(selectedTab == 0 ? 1 : 0)
                .animation(.easeInOut(duration: 0.5), value: selectedTab)
            }
            .navigationTitle("Dreamflow")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView().environmentObject(userStats)) {
                        Image(systemName: "person.crop.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}
