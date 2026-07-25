/**
 * Access information about custom metadata. The PaymentGatewayAdapter can send CustomMetadataTypeInfo to transaction requests through the response objectâ€™s SalesforceResultCodeInfo .
 */
global class CustomMetadataTypeInfo {

  global CustomMetadataTypeInfo(String cmtRecordId, String cmtSfResultCodeFieldName) {}

  global Object clone() {}

}