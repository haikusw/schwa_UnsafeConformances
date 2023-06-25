import CoreGraphics
import simd

// MARK; CoreGraphics - Hashable

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        x.hash(into: &hasher)
        y.hash(into: &hasher)
    }
}

extension CGSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        width.hash(into: &hasher)
        height.hash(into: &hasher)
    }
}

extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        origin.hash(into: &hasher)
        size.hash(into: &hasher)
    }
}

// MARK; SIMD: Hashable

extension simd_quatf: Hashable {
    public func hash(into hasher: inout Hasher) {
        vector.hash(into: &hasher)
    }

    public var hashValue: Int {
        return vector.hashValue
    }
}

extension simd_quatd: Hashable {
    public func hash(into hasher: inout Hasher) {
        vector.hash(into: &hasher)
    }

    public var hashValue: Int {
        return vector.hashValue
    }
}

extension simd_float4x4: Hashable {
    public func hash(into hasher: inout Hasher) {
        columns.0.hash(into: &hasher)
        columns.1.hash(into: &hasher)
        columns.2.hash(into: &hasher)
        columns.3.hash(into: &hasher)
    }
}

extension simd_float4x4: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let scalars = try container.decode([Float].self)
        let columns = (
            SIMD4<Float>(scalars[0..<4]),
            SIMD4<Float>(scalars[4..<8]),
            SIMD4<Float>(scalars[8..<12]),
            SIMD4<Float>(scalars[12..<16])
        )
        self = .init(columns: columns)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let scalars = [
            columns.0[0], columns.0[1], columns.0[2], columns.0[3],
            columns.1[0], columns.1[1], columns.1[2], columns.1[3],
            columns.2[0], columns.2[1], columns.2[2], columns.2[3],
            columns.3[0], columns.3[1], columns.3[2], columns.3[3],
        ]
        try container.encode(scalars)
    }
}

