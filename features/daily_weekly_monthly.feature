Feature: Daily, weekly and monthly backups

  Scenario Outline: Creating new backups
    Given it is the correct day for <Period> backups
    When I run the backups
    Then I can see a <Period> backup file
    And the <Period> backup file contains the backup command contents
    Examples:
      | Period  |
      | daily   |
      | weekly  |
      | monthly |

  Scenario Outline: Cleaning up old backups
    Given it is the correct day for <Period> backups
    And there are old <Period> backups
    When I run the backups
    Then the old <Period> backups have been removed
    Examples:
      | Period  |
      | daily   |
      | weekly  |
      | monthly |

  Scenario: Notifying a failed run
    Given it is the correct day for daily backups
    When I run the backup and it fails
    Then I have been notified of the failure
