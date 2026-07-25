/**
 * Personalization audience criteria.
 */
global class AudienceCriteriaDetail {

  global AudienceCriteriaDetail() {}

  /**
   * List of mappings of audience criteria fields and values.
   */
  global List < ConnectApi.AudienceCriterionDetail > criterion;

  /**
   * Number associated with the audience criterion in a formula. For example, (1 AND 2) OR 3. If unspecified, criteria are assigned numbers in the order that theyâ€™re added.
   */
  global Integer criterionNumber;

  /**
   * Operator used in the personalization audience criterion. Values are: Contains Equal GreaterThan GreaterThanOrEqual Includes LessThan LessThanOrEqual NotEqual NotIncludes StartsWith
   */
  global ConnectApi.AudienceCriteriaOperator criterionOperator;

  /**
   * Type of personalization audience criterion. Values are: Audience â€”Criterion based on audience. Default â€”Audience has no criteria. Domain â€”Criterion based on domain. FieldBased â€”Criterion based on object fields. GeoLocation â€”Criterion based on location. Permission â€”Criterion based on standard or custom permissions. Profile â€”Criterion based on profile.
   */
  global ConnectApi.AudienceCriteriaType criterionType;

  global Object clone() {}

}