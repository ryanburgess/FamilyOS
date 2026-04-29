import SwiftUI
import Foundation

struct TodayDashboardView: View {
    @EnvironmentObject private var store: FamilyOSStore
    @State private var currentWeather: CurrentWeather?
    @State private var isLoadingWeather = false
    @State private var weatherErrorMessage: String?

    private var timeBasedGreeting: String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 5..<12:
            return "Good morning"
        case 12..<17:
            return "Good afternoon"
        default:
            return "Good evening"
        }
    }

    private var formattedTodayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: Date())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(timeBasedGreeting), Ryan.")
                            .font(.system(size: 28, weight: .bold))

                        HStack(spacing: 10) {
                            Text(formattedTodayDate)

                            if let currentWeather {
                                Text(currentWeather.symbol)
                                Text("\(currentWeather.temperature)°")
                            } else if isLoadingWeather {
                                Text("Loading weather…")
                            } else if weatherErrorMessage != nil {
                                Text("Weather unavailable")
                            }
                        }
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button {
                        store.showingCreateEvent = true
                    } label: {
                        Label("Create", systemImage: "plus")
                            .font(.system(size: 13, weight: .semibold))
                            .padding(.horizontal, 16)
                            .frame(height: 34)
                    }
                    .buttonStyle(.borderedProminent)

                    Button {} label: {
                        Image(systemName: "ellipsis")
                    }
                    .buttonStyle(.bordered)
                }

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    ScheduleCard(events: store.events)
                        .frame(height: 260)
                    RemindersCard(reminders: store.reminders)
                        .frame(height: 260)
                    AllowanceOverviewCard(accounts: store.allowanceAccounts)
                        .frame(height: 260)
                    WeatherCard(weather: currentWeather, isLoading: isLoadingWeather, errorMessage: weatherErrorMessage)
                        .frame(height: 220)
                    WeekCard()
                        .frame(height: 220)
                    ChoresAtGlanceCard(chores: store.chores)
                        .frame(height: 220)
                }
            }
            .padding(26)
        }
        .task {
            await loadCurrentWeather()
        }
    }
}

struct CurrentWeather: Equatable {
    let temperature: Int
    let highTemperature: Int
    let lowTemperature: Int
    let condition: String
    let symbol: String
}

private struct OpenMeteoResponse: Decodable {
    let current: Current
    let daily: Daily

    struct Current: Decodable {
        let temperature2m: Double
        let weatherCode: Int

        enum CodingKeys: String, CodingKey {
            case temperature2m = "temperature_2m"
            case weatherCode = "weather_code"
        }
    }

    struct Daily: Decodable {
        let temperature2mMax: [Double]
        let temperature2mMin: [Double]

        enum CodingKeys: String, CodingKey {
            case temperature2mMax = "temperature_2m_max"
            case temperature2mMin = "temperature_2m_min"
        }
    }
}

private extension TodayDashboardView {
    func loadCurrentWeather() async {
        guard !isLoadingWeather else { return }

        await MainActor.run {
            isLoadingWeather = true
            weatherErrorMessage = nil
        }

        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=34.1486&longitude=-118.3965&current=temperature_2m,weather_code&daily=temperature_2m_max,temperature_2m_min&temperature_unit=fahrenheit&timezone=America%2FLos_Angeles"

        guard let url = URL(string: urlString) else {
            await MainActor.run {
                weatherErrorMessage = "Invalid weather URL"
                isLoadingWeather = false
            }
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
            let weather = CurrentWeather(
                temperature: Int(response.current.temperature2m.rounded()),
                highTemperature: Int((response.daily.temperature2mMax.first ?? response.current.temperature2m).rounded()),
                lowTemperature: Int((response.daily.temperature2mMin.first ?? response.current.temperature2m).rounded()),
                condition: weatherDescription(for: response.current.weatherCode),
                symbol: weatherSymbol(for: response.current.weatherCode)
            )

            await MainActor.run {
                currentWeather = weather
                isLoadingWeather = false
            }
        } catch {
            await MainActor.run {
                weatherErrorMessage = error.localizedDescription
                isLoadingWeather = false
            }
        }
    }

    func weatherDescription(for code: Int) -> String {
        switch code {
        case 0:
            return "Clear"
        case 1, 2:
            return "Mostly Sunny"
        case 3:
            return "Cloudy"
        case 45, 48:
            return "Foggy"
        case 51, 53, 55, 56, 57:
            return "Drizzle"
        case 61, 63, 65, 66, 67, 80, 81, 82:
            return "Rain"
        case 71, 73, 75, 77, 85, 86:
            return "Snow"
        case 95, 96, 99:
            return "Thunderstorm"
        default:
            return "Weather"
        }
    }

    func weatherSymbol(for code: Int) -> String {
        switch code {
        case 0:
            return "☀️"
        case 1, 2:
            return "🌤️"
        case 3:
            return "☁️"
        case 45, 48:
            return "🌫️"
        case 51, 53, 55, 56, 57:
            return "🌦️"
        case 61, 63, 65, 66, 67, 80, 81, 82:
            return "🌧️"
        case 71, 73, 75, 77, 85, 86:
            return "🌨️"
        case 95, 96, 99:
            return "⛈️"
        default:
            return "☀️"
        }
    }
}
