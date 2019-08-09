///
//  Generated code. Do not modify.
//  source: protos/user.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:protobuf/protobuf.dart' as $pb;

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('User')
    ..aOS(1, 'uid')
    ..aOS(2, 'providerId')
    ..aOS(3, 'displayName')
    ..aOS(4, 'email')
    ..aOB(5, 'isEmailVerified')
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User() => create();
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  User clone() => User()..mergeFromMessage(this);
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  static User getDefault() => _defaultInstance ??= create()..freeze();
  static User _defaultInstance;

  $core.String get uid => $_getS(0, '');
  set uid($core.String v) { $_setString(0, v); }
  $core.bool hasUid() => $_has(0);
  void clearUid() => clearField(1);

  $core.String get providerId => $_getS(1, '');
  set providerId($core.String v) { $_setString(1, v); }
  $core.bool hasProviderId() => $_has(1);
  void clearProviderId() => clearField(2);

  $core.String get displayName => $_getS(2, '');
  set displayName($core.String v) { $_setString(2, v); }
  $core.bool hasDisplayName() => $_has(2);
  void clearDisplayName() => clearField(3);

  $core.String get email => $_getS(3, '');
  set email($core.String v) { $_setString(3, v); }
  $core.bool hasEmail() => $_has(3);
  void clearEmail() => clearField(4);

  $core.bool get isEmailVerified => $_get(4, false);
  set isEmailVerified($core.bool v) { $_setBool(4, v); }
  $core.bool hasIsEmailVerified() => $_has(4);
  void clearIsEmailVerified() => clearField(5);
}

