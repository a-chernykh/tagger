Feature: Manage tags
  In order to be able to manage tags
  User wants to view and hit tags

  Background: various tags exist
    Given the following tags exist
    | name  | hits |
    | tag 1 | 10   |
    | tag 2 | 20   |
    | tag 3 | 30   |

  Scenario: View tags
    Given I am on the tags page
    Then I should see "tag 1 (10)"
    And I should see "tag 2 (20)"
    And I should see "tag 3 (30)"

  Scenario: Hit tag
    Given I am on the tags page
    Then I should see "tag 1 (10)"
    When I follow "tag 1"
    Then I should be on the tags page
    And I should see "tag 1 (11)"
