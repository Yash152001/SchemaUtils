/**
 * Represents a successfully enqueued API digest job request.
 */
global class DigestJob {

  global DigestJob() {}

  /**
   * Time period thatâ€™s included in a Chatter email digest. Values are: DailyDigest â€”The email includes up to the 50 latest posts from the previous day. WeeklyDigest â€”The email includes up to the 50 latest posts from the previous week.
   */
  global ConnectApi.DigestPeriod period;

  global Object clone() {}

}