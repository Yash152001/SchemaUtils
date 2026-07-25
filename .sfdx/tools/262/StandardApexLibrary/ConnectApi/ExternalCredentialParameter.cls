/**
 * External credential parameter.
 */
global class ExternalCredentialParameter {

  global ExternalCredentialParameter() {}

  /**
   * Parameter ID.
   */
  global String id;

  /**
   * Parameter description.
   */
  global String parameterDescription;

  /**
   * Parameter name. If the parameterType is AuthParameter , valid values are: AwsAccountId â€”Valid for AwsSv4. AwsProfileArn â€”Valid for AwsSv4 with RolesAnywhere. AwsRegion â€”Valid for AwsSv4. AwsService â€”Valid for AwsSv4. AwsStsDuration â€”Valid for AwsSv4 with STS or RolesAnywhere. AwsStsExternalId â€”Valid for AwsSv4 with STS. AwsTrustAnchorArn â€”Valid for AwsSv4 with RolesAnywhere. Scope â€”Valid for OAuth. Other parameter types can be any value.
   */
  global String parameterName;

  /**
   * Parameter type of the external credential. Values are: AdditionalRefreshStatusCode AuthParameter AuthProvider AuthProviderUrl AuthProviderUrlQueryParameter JwtBodyClaim JwtHeaderClaim ManagedByComponent ManagedByFeature SfHttpRequestExtensionName SigningCertificate
   */
  global ConnectApi.ExternalCredentialParameterType parameterType;

  /**
   * Parameter value. If the parameterType is JwtBodyClaim or JwtHeaderClaim , the parameter value can contain formulas. If the parameterType is AuthProvider or SigningCertificate , the parameter value is the fully qualified entity name of the corresponding entity.
   */
  global String parameterValue;

  global Object clone() {}

}