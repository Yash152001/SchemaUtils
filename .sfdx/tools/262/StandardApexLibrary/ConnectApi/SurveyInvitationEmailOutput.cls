/**
 * Survey invitation email.
 */
global class SurveyInvitationEmailOutput {

  global SurveyInvitationEmailOutput() {}

  /**
   * Error code for the failed call.
   */
  global Integer errorCode;

  /**
   * Details explaining why the call failed.
   */
  global String errorMessage;

  /**
   * Status of a survey invitation email. Values are: Failed â€”The survey invitation email wasn't sent. Queued â€”The survey invitation email is queued for sending.
   */
  global ConnectApi.SurveyEmailStatusEnum status;

  global Object clone() {}

}