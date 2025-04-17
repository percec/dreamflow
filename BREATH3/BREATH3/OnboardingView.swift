import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @State private var currentPage = 0
    @State private var animatePage = false
    
    let pages = [
        ("Welcome to Dreamflow", "Improve your sleep quality with guided exercises, meditations, and real progress tracking."),
        ("Breathe & Relax", "Discover a variety of breathing techniques to calm your mind and body."),
        ("Guided Meditations", "Listen to soothing meditations and stories for a better night's sleep.")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(pages[currentPage].0)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(animatePage ? 1 : 0)
                    .animation(.easeIn(duration: 0.8), value: animatePage)
                Text(pages[currentPage].1)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(animatePage ? 1 : 0)
                    .animation(.easeIn(duration: 1.0), value: animatePage)
            }
            .onAppear { animatePage = true }
            .transition(.slide)
            
            Spacer()
            HStack {
                ForEach(0..<pages.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? Color.primary : Color.gray.opacity(0.5))
                        .frame(width: index == currentPage ? 12 : 10, height: index == currentPage ? 12 : 10)
                        .animation(.easeInOut, value: currentPage)
                }
            }
            .padding(.bottom, 20)
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    if currentPage < pages.count - 1 {
                        currentPage += 1
                        animatePage = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            animatePage = true
                        }
                    } else {
                        hasSeenOnboarding = true
                    }
                }
            }) {
                Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primary)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 30)
        }
        .background(Color(UIColor.systemBackground))
    }
}
