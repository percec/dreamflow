import SwiftUI

struct ExerciseSelectionView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Choose a Breathing Exercise")
                    .font(.title2)
                    .fontWeight(.medium)
                
                NavigationLink(destination: ExerciseView()) {
                    Text("Start 4-7-8 Breathing")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}
