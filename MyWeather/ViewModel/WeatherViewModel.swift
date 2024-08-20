import Foundation
import Combine
class WeatherViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var weather: WeatherModel? = nil
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchData(latitude: Double, longitude: Double) {
        guard var urlComponents = URLComponents(string: baseURL) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Request completed")
                case .failure(let error):
                    print("Error occurred: \(error)")
                }
            } receiveValue: { returnedData in
                print("Received data: \(returnedData)")
                self.weather = returnedData
            }
            .store(in: &cancellables)
    }
    
    
    
    
}
