import Foundation

public struct TestCase3<P1, P2, P3>: Sequence {
    public typealias Iterator = IndexingIterator<Array<(UInt, P1, P2, P3)>>
    public struct Parameter {
        let line: UInt
        let value1: P1
        let value2: P2
        let value3: P3

        public init(_ line: UInt = #line, @ParameterBuilder parameterBuilder: () -> (P1, P2, P3)) {
            self.line = line
            (value1, value2, value3) = parameterBuilder()
        }
    }

    @resultBuilder
    public struct ParametersBuilder {
        public static func buildBlock(_ components: Parameter...) -> [Parameter] {
            components
        }
    }

    @resultBuilder
    public struct ParameterBuilder {
        public static func buildBlock(_ p1: P1, _ p2: P2, _ p3: P3) -> (P1, P2, P3) {
            (p1, p2, p3)
        }

    }

    private let parameters: [(UInt, P1, P2, P3)]

    public init(@ParametersBuilder parametersBuilder: (Parameter.Type) -> [Parameter]) {
        let parameterContainers = parametersBuilder(Parameter.self)
        parameters = parameterContainers.map { ($0.line, $0.value1, $0.value2, $0.value3) }
    }

    public func makeIterator() -> Iterator {
        parameters.makeIterator()
    }
}
