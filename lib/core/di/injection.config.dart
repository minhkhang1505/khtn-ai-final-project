// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/local/auth_local_data_source.dart' as _i929;
import '../../data/datasources/remote/auth_remote_data_source.dart' as _i624;
import '../../data/datasources/remote/bot_remote_data_source.dart' as _i778;
import '../../data/datasources/remote/chat_remote_data_source.dart' as _i26;
import '../../data/datasources/remote/email_remote_data_source.dart' as _i453;
import '../../data/datasources/remote/knowledge_base_remote_data_source.dart'
    as _i628;
import '../../data/datasources/remote/prompt_remote_data_source.dart' as _i928;
import '../../data/datasources/remote/user_remote_data_source.dart' as _i41;
import '../../data/repositories/ai_email_repository_implement.dart' as _i572;
import '../../data/repositories/auth_repository_implement.dart' as _i979;
import '../../data/repositories/bot_repository_implement.dart' as _i983;
import '../../data/repositories/chat_repository_implement.dart' as _i441;
import '../../data/repositories/knowledge_base_repository_implement.dart'
    as _i676;
import '../../data/repositories/prompt_repository_implement.dart' as _i803;
import '../../data/repositories/user_repository_implement.dart' as _i1063;
import '../../domain/entities/knowledge_entity.dart' as _i54;
import '../../domain/entities/prompt_entity.dart' as _i777;
import '../../domain/repositories/ai_email_repository.dart' as _i803;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/bot_repository.dart' as _i505;
import '../../domain/repositories/chat_repository.dart' as _i1072;
import '../../domain/repositories/knowledge_base_repository.dart' as _i618;
import '../../domain/repositories/prompt_repository.dart' as _i364;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/usecases/aiemail/ai_email_usecase.dart' as _i95;
import '../../domain/usecases/aiemail/sugguest_reply_idea_usecase.dart'
    as _i227;
import '../../domain/usecases/auth/get_user_usecase.dart' as _i180;
import '../../domain/usecases/auth/login_usecase.dart' as _i461;
import '../../domain/usecases/auth/logout_usecase.dart' as _i320;
import '../../domain/usecases/auth/refresh_token_usecase.dart' as _i407;
import '../../domain/usecases/auth/sign_up_usecase.dart' as _i270;
import '../../domain/usecases/bot/bot_usecase.dart' as _i692;
import '../../domain/usecases/chat/chat_usecase.dart' as _i423;
import '../../domain/usecases/datasource/upload_multiple_file_usecase.dart'
    as _i645;
import '../../domain/usecases/knowledge/create_knowledge_usecase.dart' as _i42;
import '../../domain/usecases/knowledge/delete_knowledge_usecase.dart' as _i291;
import '../../domain/usecases/knowledge/get_knowledges_usecase.dart' as _i402;
import '../../domain/usecases/knowledge/update_knowledge_usecase.dart'
    as _i1034;
import '../../domain/usecases/prompts/add_prompt_to_fav.dart' as _i209;
import '../../domain/usecases/prompts/create_prompt_usecase.dart' as _i175;
import '../../domain/usecases/prompts/delete_prompt_usecase.dart' as _i199;
import '../../domain/usecases/prompts/get_prompt_usecase.dart' as _i928;
import '../../domain/usecases/prompts/remove_prompt_from_favorite.dart'
    as _i761;
import '../../domain/usecases/prompts/udpate_prompt_usecase.dart' as _i662;
import '../../presentation/viewmodels/agent/agent_view_model.dart' as _i1071;
import '../../presentation/viewmodels/aiemail/ai_email_viewmodel.dart' as _i998;
import '../../presentation/viewmodels/auth/auth_view_model.dart' as _i376;
import '../../presentation/viewmodels/auth/user_view_model.dart' as _i511;
import '../../presentation/viewmodels/bot/bot_view_model.dart' as _i626;
import '../../presentation/viewmodels/bot/create_bot_view_model.dart' as _i219;
import '../../presentation/viewmodels/bot/edit_bot_view_model.dart' as _i24;
import '../../presentation/viewmodels/chat/chat_view_model.dart' as _i959;
import '../../presentation/viewmodels/knowledge/create_knowledge_base_viewmodel.dart'
    as _i1046;
import '../../presentation/viewmodels/knowledge/datasource_viewmodel.dart'
    as _i838;
import '../../presentation/viewmodels/knowledge/knowledge_base_viewmodel.dart'
    as _i124;
import '../../presentation/viewmodels/knowledge/knowledge_detail_viewmodel.dart'
    as _i1032;
import '../../presentation/viewmodels/prompt/create_prompt_viewmodel.dart'
    as _i731;
import '../../presentation/viewmodels/prompt/prompt_detail_view_model.dart'
    as _i39;
import '../../presentation/viewmodels/prompt/prompt_viewmodel.dart' as _i208;
import '../../presentation/viewmodels/theme_provider.dart' as _i338;
import '../network/auth_api_client.dart' as _i752;
import '../network/bot_api_client.dart' as _i18;
import '../network/jarvis_api_client.dart' as _i963;
import '../network/knowledge_base_api_client.dart' as _i687;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1071.AgentViewModel>(() => _i1071.AgentViewModel());
    gh.singleton<_i338.ThemeProvider>(() => _i338.ThemeProvider());
    gh.lazySingleton<_i929.AuthLocalDataSource>(
      () => _i929.AuthLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i752.AuthApiClient>(
      () => _i752.AuthApiClient(gh<_i929.AuthLocalDataSource>()),
    );
    await gh.lazySingletonAsync<_i18.BotApiClient>(
      () => _i18.BotApiClient.create(gh<_i929.AuthLocalDataSource>()),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i963.JarvisApiClient>(
      () => _i963.JarvisApiClient.create(gh<_i929.AuthLocalDataSource>()),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i687.KnowledgeBaseApiClient>(
      () =>
          _i687.KnowledgeBaseApiClient.create(gh<_i929.AuthLocalDataSource>()),
      preResolve: true,
    );
    gh.lazySingleton<_i624.AuthRemoteDataSource>(
      () => _i624.AuthRemoteDataSourceImpl(gh<_i752.AuthApiClient>()),
    );
    gh.lazySingleton<_i41.UserRemoteDataSource>(
      () => _i41.UserRemoteDataSourceImpl(gh<_i963.JarvisApiClient>()),
    );
    gh.lazySingleton<_i453.EmailRemoteDataSource>(
      () => _i453.EmailRemoteDataSourceImpl(gh<_i963.JarvisApiClient>()),
    );
    gh.lazySingleton<_i928.PromptRemoteDataSource>(
      () => _i928.PromptRemoteDataSourceImpl(gh<_i963.JarvisApiClient>()),
    );
    gh.lazySingleton<_i26.ChatRemoteDataSource>(
      () => _i26.ChatRemoteDataSourceImpl(gh<_i963.JarvisApiClient>()),
    );
    gh.lazySingleton<_i628.KnowledgeBaseRemoteDataSource>(
      () => _i628.KnowledgeBaseRemoteDataSourceImpl(
        gh<_i687.KnowledgeBaseApiClient>(),
      ),
    );
    gh.lazySingleton<_i778.BotRemoteDataSource>(
      () => _i778.BotRemoteDataSourceImpl(gh<_i18.BotApiClient>()),
    );
    gh.lazySingleton<_i1073.AuthRepository>(
      () => _i979.AuthRepositoryImpl(
        remoteDataSource: gh<_i624.AuthRemoteDataSource>(),
        localDataSource: gh<_i929.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i271.UserRepository>(
      () => _i1063.UserRepositoryImpl(gh<_i41.UserRemoteDataSource>()),
    );
    gh.lazySingleton<_i618.KnowledgeBaseRepository>(
      () => _i676.KnowledgeBaseRepositoryImplement(
        remoteDataSource: gh<_i628.KnowledgeBaseRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i364.PromptRepository>(
      () => _i803.PromptRepositoryImpl(gh<_i928.PromptRemoteDataSource>()),
    );
    gh.lazySingleton<_i1072.ChatRepository>(
      () => _i441.ChatRepositoryImpl(gh<_i26.ChatRemoteDataSource>()),
    );
    gh.lazySingleton<_i423.ChatUseCase>(
      () => _i423.ChatUseCase(chatRepository: gh<_i1072.ChatRepository>()),
    );
    gh.lazySingleton<_i803.AiEmailRepository>(
      () => _i572.AiEmailRepositoryImplement(
        remoteDataSource: gh<_i453.EmailRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i227.SugguestReplyIdeaUsecase>(
      () => _i227.SugguestReplyIdeaUsecase(
        aiEmailRepository: gh<_i803.AiEmailRepository>(),
      ),
    );
    gh.lazySingleton<_i461.LoginUsecase>(
      () => _i461.LoginUsecase(authRepository: gh<_i1073.AuthRepository>()),
    );
    gh.lazySingleton<_i320.LogoutUsecase>(
      () => _i320.LogoutUsecase(authRepository: gh<_i1073.AuthRepository>()),
    );
    gh.lazySingleton<_i407.RefreshTokenUsecase>(
      () => _i407.RefreshTokenUsecase(
        authRepository: gh<_i1073.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i209.AddPromptToFavoriteUsecase>(
      () => _i209.AddPromptToFavoriteUsecase(gh<_i364.PromptRepository>()),
    );
    gh.lazySingleton<_i175.CreatePromptUsecase>(
      () => _i175.CreatePromptUsecase(gh<_i364.PromptRepository>()),
    );
    gh.lazySingleton<_i199.DeletePromptUsecase>(
      () => _i199.DeletePromptUsecase(gh<_i364.PromptRepository>()),
    );
    gh.lazySingleton<_i928.GetPromptUseCase>(
      () => _i928.GetPromptUseCase(gh<_i364.PromptRepository>()),
    );
    gh.lazySingleton<_i761.RemovePromptFromFavoriteUsecase>(
      () => _i761.RemovePromptFromFavoriteUsecase(gh<_i364.PromptRepository>()),
    );
    gh.lazySingleton<_i645.UploadMultipleFileUsecase>(
      () => _i645.UploadMultipleFileUsecase(
        repository: gh<_i618.KnowledgeBaseRepository>(),
      ),
    );
    gh.lazySingleton<_i42.CreateKnowledgeUsecase>(
      () => _i42.CreateKnowledgeUsecase(
        repository: gh<_i618.KnowledgeBaseRepository>(),
      ),
    );
    gh.lazySingleton<_i291.DeleteKnowledgeBaseUsecase>(
      () => _i291.DeleteKnowledgeBaseUsecase(
        repository: gh<_i618.KnowledgeBaseRepository>(),
      ),
    );
    gh.lazySingleton<_i1034.UpdateKnowledgeBaseUsecase>(
      () => _i1034.UpdateKnowledgeBaseUsecase(
        repository: gh<_i618.KnowledgeBaseRepository>(),
      ),
    );
    gh.lazySingleton<_i505.BotRepository>(
      () => _i983.BotRepositoryImpl(gh<_i778.BotRemoteDataSource>()),
    );
    gh.factoryParam<
      _i1032.KnowledgeDetailViewmodel,
      _i54.KnowledgeEntity,
      dynamic
    >(
      (knowledge, _) => _i1032.KnowledgeDetailViewmodel(
        knowledge: knowledge,
        updateKnowledgeBaseUsecase: gh<_i1034.UpdateKnowledgeBaseUsecase>(),
      ),
    );
    gh.lazySingleton<_i402.GetKnowledgesUsecase>(
      () => _i402.GetKnowledgesUsecase(gh<_i618.KnowledgeBaseRepository>()),
    );
    gh.lazySingleton<_i270.SignUpUseCase>(
      () => _i270.SignUpUseCase(repository: gh<_i1073.AuthRepository>()),
    );
    gh.factory<_i208.PromptViewmodel>(
      () => _i208.PromptViewmodel(
        getPromptUseCase: gh<_i928.GetPromptUseCase>(),
        createPromptUseCase: gh<_i175.CreatePromptUsecase>(),
        deletePromptUseCase: gh<_i199.DeletePromptUsecase>(),
        addPromptToFavoriteUseCase: gh<_i209.AddPromptToFavoriteUsecase>(),
        removePromptFromFavoriteUsecase:
            gh<_i761.RemovePromptFromFavoriteUsecase>(),
      ),
    );
    gh.lazySingleton<_i692.BotUseCase>(
      () => _i692.BotUseCase(botRepository: gh<_i505.BotRepository>()),
    );
    gh.lazySingleton<_i662.UpdatePromptUsecase>(
      () => _i662.UpdatePromptUsecase(repository: gh<_i364.PromptRepository>()),
    );
    gh.factory<_i731.CreatePromptViewModel>(
      () => _i731.CreatePromptViewModel(
        createPromptUseCase: gh<_i175.CreatePromptUsecase>(),
      ),
    );
    gh.factory<_i376.AuthViewModel>(
      () => _i376.AuthViewModel(
        signUpUseCase: gh<_i270.SignUpUseCase>(),
        loginUsecase: gh<_i461.LoginUsecase>(),
        logoutUsecase: gh<_i320.LogoutUsecase>(),
      ),
    );
    gh.factory<_i124.KnowledgeBaseViewmodel>(
      () => _i124.KnowledgeBaseViewmodel(
        getKnowledgesUsecase: gh<_i402.GetKnowledgesUsecase>(),
        deleteKnowledgeBaseUsecase: gh<_i291.DeleteKnowledgeBaseUsecase>(),
      ),
    );
    gh.lazySingleton<_i180.GetUserUseCase>(
      () => _i180.GetUserUseCase(userRepository: gh<_i271.UserRepository>()),
    );
    gh.factory<_i838.DatasourceViewmodel>(
      () => _i838.DatasourceViewmodel(
        uploadMultipleFileUsecase: gh<_i645.UploadMultipleFileUsecase>(),
      ),
    );
    gh.lazySingleton<_i95.AiEmailUsecase>(
      () => _i95.AiEmailUsecase(repository: gh<_i803.AiEmailRepository>()),
    );
    gh.factory<_i511.UserViewModel>(
      () => _i511.UserViewModel(getUserUseCase: gh<_i180.GetUserUseCase>()),
    );
    gh.factory<_i1046.CreateKnowledgeBaseViewmodel>(
      () => _i1046.CreateKnowledgeBaseViewmodel(
        createKnowledgeUsecase: gh<_i42.CreateKnowledgeUsecase>(),
      ),
    );
    gh.factoryParam<_i39.PromptDetailViewModel, _i777.PromptEntity, dynamic>(
      (prompt, _) => _i39.PromptDetailViewModel(
        getPromptUseCase: gh<_i928.GetPromptUseCase>(),
        updatePromptUseCase: gh<_i662.UpdatePromptUsecase>(),
        deletePromptUseCase: gh<_i199.DeletePromptUsecase>(),
        prompt: prompt,
      ),
    );
    gh.factory<_i626.BotViewModel>(
      () => _i626.BotViewModel(botUseCase: gh<_i692.BotUseCase>()),
    );
    gh.factory<_i219.CreateBotViewModel>(
      () => _i219.CreateBotViewModel(botUseCase: gh<_i692.BotUseCase>()),
    );
    gh.factory<_i24.EditBotViewModel>(
      () => _i24.EditBotViewModel(botUseCase: gh<_i692.BotUseCase>()),
    );
    gh.factory<_i959.ChatViewModel>(
      () => _i959.ChatViewModel(
        chatUsecase: gh<_i423.ChatUseCase>(),
        getUserUseCase: gh<_i180.GetUserUseCase>(),
      ),
    );
    gh.factory<_i998.AiEmailViewmodel>(
      () => _i998.AiEmailViewmodel(
        aiEmailUsecase: gh<_i95.AiEmailUsecase>(),
        sugguestReplyIdeaUsecase: gh<_i227.SugguestReplyIdeaUsecase>(),
      ),
    );
    return this;
  }
}
