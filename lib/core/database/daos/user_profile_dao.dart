import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_profiles_table.dart';

part 'user_profile_dao.g.dart';

@DriftAccessor(tables: [UserProfiles])
class UserProfileDao extends DatabaseAccessor<AppDatabase>
    with _$UserProfileDaoMixin {
  UserProfileDao(super.db);

  /// Watch the singleton profile row.
  Stream<UserProfile> watchProfile() {
    return (select(userProfiles)..limit(1)).watchSingle();
  }

  /// Get the profile synchronously.
  Future<UserProfile> getProfile() {
    return (select(userProfiles)..limit(1)).getSingle();
  }

  /// Update the profile.
  Future<bool> updateProfile(UserProfilesCompanion companion) {
    return (update(userProfiles)
          ..where((t) => t.id.equals(1)))
        .write(companion.copyWith(
          updatedAt: Value(DateTime.now()),
        ))
        .then((rows) => rows > 0);
  }

  /// Get and increment the next invoice number.
  Future<String> getNextInvoiceNumber() {
    return transaction(() async {
      final profile = await getProfile();
      final number = profile.nextInvoiceNumber;
      final formatted =
          '${profile.invoiceNumberPrefix}${number.toString().padLeft(4, '0')}';
      await (update(userProfiles)..where((t) => t.id.equals(1))).write(
        UserProfilesCompanion(
          nextInvoiceNumber: Value(number + 1),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return formatted;
    });
  }
}
