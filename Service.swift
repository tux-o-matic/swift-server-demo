import OpenAPIRuntime
import OpenAPIVapor
import Vapor
import EventAPI

@main
struct Service {
  static func main() async throws {
    let application = try await Vapor.Application.make()
    let transport = VaporTransport(routesBuilder: application)

    let service = Service()
    try service.registerHandlers(
      on: transport,
      serverURL: URL(string: "/api")!
    )

    try await application.execute()
  }
}

extension Service: APIProtocol {
  func listEvents(
    _ input: Operations.listEvents.Input
  ) async throws -> Operations.listEvents.Output {
    let logger = Logger(label: "ListEvents")
    logger.info("Handling request", metadata: ["operation": "\(Operations.listEvents.id)"])
    
    let events: [Components.Schemas.Event] = [
      .init(name: "Server-Side Swift Conference", date: "26.09.2024", attendee: "Gus"),
      .init(name: "Oktoberfest", date: "21.09.2024", attendee: "Werner"),
    ]

    return .ok(.init(body: .json(events)))
  }

  func createEvent(
    _ input: Operations.createEvent.Input
  ) async throws -> Operations.createEvent.Output {
    return .undocumented(statusCode: 501, .init())
  }
}
