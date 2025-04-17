import SwiftUI

struct FlowerAnimationView: View {
    @State private var rotation: Double = 0.0
    @State private var pulse: Bool = false

    var body: some View {
        ZStack {
            // Center pulsing circle
            Circle()
                .fill(Color.pink)
                .frame(width: 30, height: 30)
                .scaleEffect(pulse ? 1.2 : 0.8)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: pulse)
            
            // Petals arranged as capsules
            ForEach(0..<8) { index in
                Capsule()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 20, height: 60)
                    .offset(y: -50)
                    .rotationEffect(.degrees(Double(index) * 45))
            }
        }
        .rotationEffect(.degrees(rotation))
        .onAppear {
            pulse = true
            withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}
