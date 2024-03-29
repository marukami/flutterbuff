// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: protos/user.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

// protoc --dart_out=./lib/gen ./protos/person.proto
// protoc --swift_out=./ios/Classes ./protos/person.proto

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct User {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var uid: String = String()

  var providerID: String = String()

  var displayName: String = String()

  var email: String = String()

  var isEmailVerified: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension User: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "User"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "uid"),
    2: .same(proto: "providerId"),
    3: .same(proto: "displayName"),
    4: .same(proto: "email"),
    5: .same(proto: "isEmailVerified"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.uid)
      case 2: try decoder.decodeSingularStringField(value: &self.providerID)
      case 3: try decoder.decodeSingularStringField(value: &self.displayName)
      case 4: try decoder.decodeSingularStringField(value: &self.email)
      case 5: try decoder.decodeSingularBoolField(value: &self.isEmailVerified)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.uid.isEmpty {
      try visitor.visitSingularStringField(value: self.uid, fieldNumber: 1)
    }
    if !self.providerID.isEmpty {
      try visitor.visitSingularStringField(value: self.providerID, fieldNumber: 2)
    }
    if !self.displayName.isEmpty {
      try visitor.visitSingularStringField(value: self.displayName, fieldNumber: 3)
    }
    if !self.email.isEmpty {
      try visitor.visitSingularStringField(value: self.email, fieldNumber: 4)
    }
    if self.isEmailVerified != false {
      try visitor.visitSingularBoolField(value: self.isEmailVerified, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: User, rhs: User) -> Bool {
    if lhs.uid != rhs.uid {return false}
    if lhs.providerID != rhs.providerID {return false}
    if lhs.displayName != rhs.displayName {return false}
    if lhs.email != rhs.email {return false}
    if lhs.isEmailVerified != rhs.isEmailVerified {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
