abstract class TodoAppStates{}

class InitialTodoAppState extends TodoAppStates{}

class ChangeBottomNavBarIndexState extends TodoAppStates{}

class ChangeBottomSheetState extends TodoAppStates{}

class CreateDatabaseSuccessState extends TodoAppStates{}
class OpenDatabaseSuccessState extends TodoAppStates{}
class CreateDatabaseErrorState extends TodoAppStates{}

class InsertToDatabaseSuccessState extends TodoAppStates{}
class InsertToDatabaseErrorState extends TodoAppStates{}

class GetDataFromDatabaseSuccessState extends TodoAppStates{}
class GetDataFromDatabaseErrorState extends TodoAppStates{}


class UpdateDataInDatabaseSuccessState extends TodoAppStates{}
class UpdateDataInDatabaseErrorState extends TodoAppStates{}

class DeleteDataFromDatabaseSuccessState extends TodoAppStates{}
class DeleteDataFromDatabaseErrorState extends TodoAppStates{}