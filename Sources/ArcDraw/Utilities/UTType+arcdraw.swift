// UTType+arcdraw.swift

import UniformTypeIdentifiers

/**
 Extend UTType to include org.bhj.arcdraw (.arcdraw) files.
 */
@available(macOS 11.0, *)
extension UTType {
  static let arcdrawDocType = UTType(exportedAs: "org.bhj.arcdraw")
}
