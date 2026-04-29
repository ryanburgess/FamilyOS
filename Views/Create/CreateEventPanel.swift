import SwiftUI

struct CreateEventPanel: View {
    @EnvironmentObject private var store: FamilyOSStore
    @State private var title = "Austin – Dentist Appointment"
    @State private var date = Date()
    @State private var startTime = "3:15 PM"
    @State private var endTime = "4:00 PM"
    @State private var location = "Studio City Dental"
    @State private var notes = "Bring insurance card. Leave by 2:45."
    @State private var category: EventCategory = .appointment

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Label("New Event", systemImage: "calendar")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button { store.showingCreateEvent = false } label: { Image(systemName: "xmark") }
                    .buttonStyle(.plain)
            }

            Group {
                field("Title", text: $title)
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Date").formLabel()
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Time").formLabel()
                        HStack {
                            TextField("Start", text: $startTime)
                            Text("to").foregroundStyle(.secondary)
                            TextField("End", text: $endTime)
                        }
                    }
                }
                field("Location", text: $location)
                field("Notes", text: $notes)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Category").formLabel()
                    Picker("Category", selection: $category) {
                        ForEach(EventCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 170)
                }
            }

            Divider()

            HStack {
                Text("Send to")
                    .font(.system(size: 13, weight: .semibold))
                Spacer()
                Button("Select All") {}
                    .buttonStyle(.plain)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.blue)
            }

            VStack(spacing: 0) {
                ForEach($store.destinations) { $destination in
                    HStack(spacing: 10) {
                        Image(systemName: destination.icon)
                            .foregroundStyle(.blue)
                            .frame(width: 20)
                        Text(destination.title)
                            .font(.system(size: 12, weight: .medium))
                        Spacer()
                        Toggle("", isOn: $destination.isEnabled)
                            .labelsHidden()
                            .toggleStyle(.switch)
                            .controlSize(.small)
                    }
                    .padding(.vertical, 8)
                    Divider()
                }
            }
            .padding(.horizontal, 2)

            Spacer()

            HStack(spacing: 10) {
                Button("Cancel") { store.showingCreateEvent = false }
                    .frame(maxWidth: .infinity)
                    .controlSize(.large)
                Button("Create Event") {}
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    .controlSize(.large)
            }
        }
        .padding(18)
        .background(Color.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.18), radius: 24, x: 0, y: 18)
    }

    private func field(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).formLabel()
            TextField(label, text: text)
                .textFieldStyle(.roundedBorder)
        }
    }
}

private extension Text {
    func formLabel() -> some View {
        self.font(.system(size: 11, weight: .medium)).foregroundStyle(.secondary)
    }
}
