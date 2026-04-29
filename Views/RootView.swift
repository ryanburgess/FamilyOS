
import SwiftUI

struct RootView: View {
    var body: some View {
        HStack(spacing: 0) {
            SidebarView()
                .frame(width: 260)

            Divider()
                .opacity(0.35)

            MainContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 1180, minHeight: 760)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.95, green: 0.97, blue: 1.0),
                    Color(red: 0.91, green: 0.94, blue: 0.99)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

#Preview {
    RootView()
        .environmentObject(FamilyOSStore())
}
