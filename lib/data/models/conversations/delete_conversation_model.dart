class DeleteConversationRequestModel {
  final String conversationId;
  final String assistantId;
  final String assistantModel;
  DeleteConversationRequestModel({required this.conversationId, required this.assistantId, required this.assistantModel});

  Map<String, dynamic> toJson() {
    return {
      'conversationIdd': conversationId,
      'assistantId': assistantId,
      'assistantModel': assistantModel,
    };
  }
}

class DeleteConversationResponseModel {
  final bool success; 

  DeleteConversationResponseModel(this.success);

  factory DeleteConversationResponseModel.fromJson(dynamic json) {
    bool resultSuccess = false; 

    if (json is bool) {
      resultSuccess = json;
    } else if (json is Map<String, dynamic> && json.containsKey('success')) {
      dynamic successValue = json['success'];
      if (successValue is bool) {
        resultSuccess = successValue;
      }
    }
    
    return DeleteConversationResponseModel(resultSuccess);
  }
}