import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/Match/match.model.dart';

class MatchesRepo extends FirestoreRepo<Match> {
  MatchesRepo()
      : super(
          'Matches',
        );

  @override
  Match? toModel(Map<String, dynamic>? item) => Match.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(Match? item) => item?.toMap() ?? {};
}
