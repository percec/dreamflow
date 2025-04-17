import SwiftUI

struct ContrastButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .light ? Color.black : Color.white)
            .foregroundColor(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(10)
            .shadow(color: colorScheme == .light ? .black.opacity(0.2) : .white.opacity(0.2),
                    radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .padding(.horizontal, 20)
    }
}
