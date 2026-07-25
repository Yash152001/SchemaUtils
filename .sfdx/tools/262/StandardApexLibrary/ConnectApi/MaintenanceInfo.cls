/**
 * Information about the upcoming scheduled maintenance for the organization.
 */
global class MaintenanceInfo {

  global MaintenanceInfo() {}

  /**
   * Description of the maintenance.
   */
  global String description;

  /**
   * Title of the maintenance.
   */
  global String maintenanceTitle;

  /**
   * Type of maintenance. Values are: Downtime â€”Downtime maintenance. GenerallyAvailable â€”Generally available mode. MaintenanceAndAvailable â€”Maintenance with available mode. MaintenanceWithDowntime â€”Scheduled maintenance with downtime. ReadOnly â€”Maintenance with read-only mode. ServiceAgreement â€”Service agreement maintenance.
   */
  global ConnectApi.MaintenanceType maintenanceType;

  /**
   * Effective time when users start seeing the maintenance message.
   */
  global Datetime messageEffectiveTime;

  /**
   * Expiration time of the maintenance message.
   */
  global Datetime messageExpirationTime;

  /**
   * Scheduled end of downtime. null for GenerallyAvailable and ReadOnly maintenance types.
   */
  global Datetime scheduledEndDowntime;

  /**
   * Scheduled end of maintenance. null for Downtime maintenance type.
   */
  global Datetime scheduledEndMaintenanceTime;

  /**
   * Scheduled start of downtime. null for GenerallyAvailable and ReadOnly maintenance types.
   */
  global Datetime scheduledStartDowntime;

  /**
   * Scheduled start time of maintenance. null for Downtime maintenance type.
   */
  global Datetime scheduledStartMaintenanceTime;

  global Object clone() {}

}