import SwiftUI

struct SidebarView: View {
    @EnvironmentObject private var store: FamilyOSStore

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Spacer().frame(height: 42)

            HStack(spacing: 10) {
                Image(systemName: "person.2.fill")
                    .font(.title2)
                Text("FamilyOS")
                    .font(.title3.bold())
            }
            .padding(.horizontal, 18)

            VStack(spacing: 4) {
                ForEach(AppSection.allCases.filter { $0 != .settings }) { section in
                    SidebarRow(section: section, isSelected: store.selectedSection == section) {
                        store.selectedSection = section
                    }
                }
            }
            .padding(.horizontal, 10)

            Divider().padding(.horizontal, 14)

            Button {
                store.showingCreateEvent.toggle()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "plus.circle")
                    Text("Create")
                }
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.primary)
                .padding(.horizontal, 10)
                .frame(height: 34)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 14)

            Spacer()

            SidebarRow(section: .settings, isSelected: store.selectedSection == .settings) {
                store.selectedSection = .settings
            }
            .padding(.horizontal, 10)

            if let ryan = store.familyMembers.first(where: { $0.name == "Ryan" }) {
                HStack(spacing: 10) {
                    AvatarView(member: ryan, size: 34)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(ryan.name).font(.system(size: 12, weight: .semibold))
                        Text(ryan.role).font(.system(size: 10)).foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 14)
            }
        }
    }
}

struct SidebarRow: View {
    let section: AppSection
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: section.icon)
                    .frame(width: 18)
                Text(section.rawValue)
                Spacer()
            }
            .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
            .foregroundStyle(isSelected ? .white : .primary)
            .padding(.horizontal, 10)
            .frame(height: 34)
            .background(isSelected ? Color.blue : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
