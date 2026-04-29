import SwiftUI

struct CardView<Content: View>: View {
    var title: String
    var systemImage: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.system(size: 17, weight: .semibold))
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            content
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(Color.white.opacity(0.78))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black.opacity(0.08), lineWidth: 1))
    }
}

struct LinkRow: View {
    let title: String

    var body: some View {
        Button {} label: {
            HStack(spacing: 6) {
                Text(title)
                Image(systemName: "arrow.right")
            }
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(.blue)
        }
        .buttonStyle(.plain)
    }
}
