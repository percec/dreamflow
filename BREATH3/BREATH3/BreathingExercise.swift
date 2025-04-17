import Foundation

struct BreathingExercise: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var animationSequence: [CGFloat]
    var phaseDurations: [UInt64]  // in nanoseconds
}
