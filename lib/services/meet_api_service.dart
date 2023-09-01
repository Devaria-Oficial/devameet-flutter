
import 'package:dartz/dartz.dart';
import 'package:devameet_flutter/errors/failures.dart';
import 'package:devameet_flutter/models/meet_model.dart';
import 'package:devameet_flutter/services/http_service.dart';

abstract class MeetApiService {
  Future<Either<Failure, List<MeetModel> >> list();
}


class MeetApiServiceImpl implements MeetApiService {
  final HttpService httpService;

  MeetApiServiceImpl({ required this.httpService });

  @override
  Future<Either<Failure, List<MeetModel>>> list() async {
    final result = await httpService.request(path: "/meet", method: "GET");


    return result.fold((failure) => Left(AppFailure("Cannot load meets")), (response){
      List<MeetModel> meets = [];
      meets = response.data.map<MeetModel>((data) => MeetModel.fromJson(data)).toList();
      return Right(meets);
    });
  }

}