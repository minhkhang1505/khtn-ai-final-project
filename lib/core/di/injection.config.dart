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
import '../../data/datasources/remote/chat_remote_data_source.dart' as _i26;
import '../../data/datasources/remote/knowledge_base_remote_data_source.dart'
    as _i628;
import '../../data/datasources/remote/prompt_remote_data_source.dart' as _i928;
import '../../data/datasources/remote/user_remote_data_source.dart' as _i41;
import '../../data/repositories/auth_repository_implement.dart' as _i979;
import '../../data/repositories/chat_repository_implement.dart' as _i441;
import '../../data/repositories/knowledge_base_repository_implement.dart'
    as _i676;
import '../../data/repositories/prompt_repository_implement.dart' as _i803;
import '../../data/repositories/user_repository_implement.dart' as _i1063;
import '../../domain/entities/knowledge_entity.dart' as _i54;
import '../../domain/entities/prompt_entity.dart' as _i777;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/chat_repository.dart' as _i1072;
import '../../domain/repositories/knowledge_base_repository.dart' as _i618;
import '../../domain/repositories/prompt_repository.dart' as _i364;
import '../../domain/repositories/user_repository.dart' as _i271;
import '../../domain/usecases/auth/get_user_usecase.dart' as _i180;
import '../../domain/usecases/auth/login_usecase.dart' as _i461;
import '../../domain/usecases/auth/logout_usecase.dart' as _i320;
import '../../domain/usecases/auth/refresh_token_usecase.dart' as _i407;
import '../../domain/usecases/auth/sign_up_usecase.dart' as _i270;
import '../../domain/usecases/chat_usecase.dart' as _i1013;
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
import '../../presentation/viewmodels/agent_view_model.dart' as _i771;
import '../../presentation/viewmodels/auth_view_model.dart' as _i912;
import '../../presentation/viewmodels/bot_view_model.dart' as _i304;
import '../../presentation/viewmodels/chat_view_model.dart' as _i540;
import '../../presentation/viewmodels/create_knowledge_base_viewmodel.dart'
    as _i363;
import '../../presentation/viewmodels/create_prompt_viewmodel.dart' as _i53;
import '../../presentation/viewmodels/knowledge_base_viewmodel.dart' as _i987;
import '../../presentation/viewmodels/knowledge_detail_viewmodel.dart' as _i688;
import '../../presentation/viewmodels/prompt_detail_view_model.dart' as _i978;
import '../../presentation/viewmodels/prompt_viewmodel.dart' as _i304;
import '../../presentation/viewmodels/theme_provider.dart' as _i338;
import '../../presentation/viewmodels/user_view_model.dart' as _i458;
import '../network/auth_api_client.dart' as _i752;
import '../network/jarvis_api_client.dart' as _i963;
import '../network/knowledge_base_api_client.dart' as _i687;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i771.AgentViewModel>(() => _i771.AgentViewModel());
    gh.factory<_i304.BotViewModel>(() => _i304.BotViewModel());
    gh.singleton<_i338.ThemeProvider>(() => _i338.ThemeProvider());
    gh.lazySingleton<_i929.AuthLocalDataSource>(
      () => _i929.AuthLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i752.AuthApiClient>(
      () => _i752.AuthApiClient(gh<_i929.AuthLocalDataSource>()),
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
    gh.lazySingleton<_i1013.ChatUseCase>(
      () => _i1013.ChatUseCase(chatRepository: gh<_i1072.ChatRepository>()),
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
    gh.factoryParam<
      _i688.KnowledgeDetailViewmodel,
      _i54.KnowledgeEntity,
      dynamic
    >(
      (knowledge, _) => _i688.KnowledgeDetailViewmodel(
        knowledge: knowledge,
        updateKnowledgeBaseUsecase: gh<_i1034.UpdateKnowledgeBaseUsecase>(),
        deleteKnowledgeBaseUsecase: gh<_i291.DeleteKnowledgeBaseUsecase>(),
      ),
    );
    gh.lazySingleton<_i402.GetKnowledgesUsecase>(
      () => _i402.GetKnowledgesUsecase(gh<_i618.KnowledgeBaseRepository>()),
    );
    gh.lazySingleton<_i270.SignUpUseCase>(
      () => _i270.SignUpUseCase(repository: gh<_i1073.AuthRepository>()),
    );
    gh.factory<_i304.PromptViewmodel>(
      () => _i304.PromptViewmodel(
        getPromptUseCase: gh<_i928.GetPromptUseCase>(),
        createPromptUseCase: gh<_i175.CreatePromptUsecase>(),
        deletePromptUseCase: gh<_i199.DeletePromptUsecase>(),
        addPromptToFavoriteUseCase: gh<_i209.AddPromptToFavoriteUsecase>(),
        removePromptFromFavoriteUsecase:
            gh<_i761.RemovePromptFromFavoriteUsecase>(),
      ),
    );
    gh.lazySingleton<_i662.UpdatePromptUsecase>(
      () => _i662.UpdatePromptUsecase(repository: gh<_i364.PromptRepository>()),
    );
    gh.factory<_i53.CreatePromptViewModel>(
      () => _i53.CreatePromptViewModel(
        createPromptUseCase: gh<_i175.CreatePromptUsecase>(),
      ),
    );
    gh.factory<_i912.AuthViewModel>(
      () => _i912.AuthViewModel(
        signUpUseCase: gh<_i270.SignUpUseCase>(),
        loginUsecase: gh<_i461.LoginUsecase>(),
        logoutUsecase: gh<_i320.LogoutUsecase>(),
      ),
    );
    gh.lazySingleton<_i180.GetUserUseCase>(
      () => _i180.GetUserUseCase(userRepository: gh<_i271.UserRepository>()),
    );
    gh.factory<_i458.UserViewModel>(
      () => _i458.UserViewModel(getUserUseCase: gh<_i180.GetUserUseCase>()),
    );
    gh.factory<_i363.CreateKnowledgeBaseViewmodel>(
      () => _i363.CreateKnowledgeBaseViewmodel(
        createKnowledgeUsecase: gh<_i42.CreateKnowledgeUsecase>(),
      ),
    );
    gh.factory<_i540.ChatViewModel>(
      () => _i540.ChatViewModel(
        chatUsecase: gh<_i1013.ChatUseCase>(),
        getUserUseCase: gh<_i180.GetUserUseCase>(),
      ),
    );
    gh.factoryParam<_i978.PromptDetailViewModel, _i777.PromptEntity, dynamic>(
      (prompt, _) => _i978.PromptDetailViewModel(
        getPromptUseCase: gh<_i928.GetPromptUseCase>(),
        updatePromptUseCase: gh<_i662.UpdatePromptUsecase>(),
        deletePromptUseCase: gh<_i199.DeletePromptUsecase>(),
        prompt: prompt,
      ),
    );
    gh.factory<_i987.KnowledgeBaseViewmodel>(
      () => _i987.KnowledgeBaseViewmodel(
        getKnowledgesUsecase: gh<_i402.GetKnowledgesUsecase>(),
      ),
    );
    return this;
  }
}
