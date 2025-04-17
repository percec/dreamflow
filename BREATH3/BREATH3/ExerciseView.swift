import SwiftUI

struct ExerciseView: View {
    @State private var animationPhase: Int = 0
    @State private var isExerciseComplete = false
    @State private var selectedDuration: Int = 240
    @State private var showDurationPicker: Bool = true
    @State private var timeRemaining: Int = 0
    @State private var exerciseTimer: Timer?
    
    private let fixedDurations: [Double] = [4, 7, 8] // inhale, hold, exhale
    
    @State private var lungScale: CGFloat = 1.0
    @State private var lungOpacity: Double = 1.0
    @State private var instructionText = "Prepare to begin"

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 30) {
                if !showDurationPicker {
                    Text(formatTime(seconds: timeRemaining))
                        .font(.system(size: 36, design: .monospaced))
                        .padding(.top)
                }
                
                if !showDurationPicker {
                    ZStack {
                        Image(systemName: "lungs.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .foregroundColor(.blue)
                            .scaleEffect(lungScale)
                            .opacity(lungOpacity)
                        
                        if !isExerciseComplete {
                            BreathingArrowsView(phase: animationPhase % 3)
                        }
                    }

                    Text(instructionText)
                        .font(.title3)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            
            if showDurationPicker {
                DurationPickerView(selectedDuration: $selectedDuration) {
                    startExercise()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            exerciseTimer?.invalidate()
        }
    }

    func startExercise() {
        withAnimation {
            showDurationPicker = false
            timeRemaining = selectedDuration
            startBreathingCycle()
            startExerciseTimer()
        }
    }

    private func startBreathingCycle() {
        Task {
            while timeRemaining > 0 {
                for (index, duration) in fixedDurations.enumerated() {
                    guard timeRemaining > 0 else { break }
                    animationPhase = index
                    await animatePhase(phaseIndex: index, duration: duration)
                }
            }
            completeExercise()
        }
    }

    private func animatePhase(phaseIndex: Int, duration: Double) async {
        let phaseType = phaseIndex % 3
        withAnimation {
            instructionText = {
                switch phaseType {
                case 0: return "Inhale deeply"
                case 1: return "Hold"
                default: return "Exhale slowly"
                }
            }()
        }

        await withCheckedContinuation { continuation in
            withAnimation(.easeInOut(duration: duration)) {
                switch phaseType {
                case 0:
                    lungScale = 1.5
                    lungOpacity = 1.0
                case 1:
                    lungScale = 1.3
                    lungOpacity = 0.8
                default:
                    lungScale = 1.0
                    lungOpacity = 0.5
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
            }
        }
    }

    private func startExerciseTimer() {
        exerciseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                exerciseTimer?.invalidate()
            }
        }
    }

    private func completeExercise() {
        withAnimation {
            isExerciseComplete = true
            instructionText = "Session Complete"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // You can add navigation or haptics here
        }
    }

    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

// MARK: - Breathing Arrows View
struct BreathingArrowsView: View {
    let phase: Int
    
    var body: some View {
        Group {
            if phase == 0 {
                Image(systemName: "arrow.down")
                    .font(.title)
                    .foregroundColor(.blue)
            } else if phase == 1 {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray)
            } else {
                Image(systemName: "arrow.up")
                    .font(.title)
                    .foregroundColor(.blue)
            }
        }
    }
}

// MARK: - Duration Picker View
struct DurationPickerView: View {
    @Binding var selectedDuration: Int
    var startAction: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Select Duration")
                .font(.title3)
                .fontWeight(.medium)
            
            Picker("Duration", selection: $selectedDuration) {
                Text("2 min").tag(120)
                Text("4 min").tag(240)
                Text("5 min").tag(300)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 40)
            
            Button(action: startAction) {
                Text("Start")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .padding()
    }
}
