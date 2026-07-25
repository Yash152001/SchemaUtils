/**
 * Sort rule.
 */
global class SortRule {

  global SortRule() {}

  /**
   * Direction of the sort rule. Values are: Ascending â€”Sorts in ascending alphanumeric order (Aâ€“Z, 0â€“9). Default â€”When no direction is defined, sorts by relevance. Descending â€”Sorts in descending alphanumeric order (Zâ€“A, 9â€“0).
   */
  global ConnectApi.CommerceSearchSortRuleDirection direction;

  /**
   * Label of the sort rule.
   */
  global String label;

  /**
   * Label suffix of the sort rule.Values are: Ascen â€”Label suffix for 'Asc' Ascending â€”Label suffix for 'Ascending' Az â€”Label suffix for 'A-Z' Descen â€”Label suffix for 'Desc' Descending â€”Label suffix for 'Descending' FewMany â€”Label suffix for 'Few-Many' HeavyLight â€”Label suffix for 'Heavy-Light' HighLow â€”Label suffix for 'High-Low' HighestLowest â€”Label suffix for 'Highest-Lowest' LightHeavy â€”Label suffix for 'Light-Heavy' LowHigh â€”Label suffix for 'Low-High' LowestHighest â€”Label suffix for 'Lowest-Highest' ManyFew â€”Label suffix for 'Many-Few' NewOld â€”Label suffix for 'New-Old' Newest â€”Label suffix for 'Newest' NewestOldest â€”Label suffix for 'Newest-Oldest' NineZero â€”Label suffix for '9-0' OldNew â€”Label suffix for 'Old-New' Oldest â€”Label suffix for 'Oldest' OldestNewest â€”Label suffix for 'Oldest-Newest' PriceDecreasing â€”Label suffix for '$$-$' PriceIncreasing â€”Label suffix for '$-$$' ThickThin â€”Label suffix for 'Thick-Thin' ThinThick â€”Label suffix for 'Thin-Thick' Za â€”Label suffix for 'Z-A' ZeroNine â€”Label suffix for '0-9'
   */
  global ConnectApi.CommerceSearchSortRuleLabelSuffix labelSuffix;

  /**
   * Name of the sort rule field or, if the sort rule is based on a custom field, ID.
   */
  global String nameOrId;

  /**
   * Sort order for the rule. A lower number has higher precedence. The first sort option is called when no other option is selected.
   */
  global Integer sortOrder;

  /**
   * ID of the sort rule.
   */
  global String sortRuleId;

  /**
   * Type of sort rule. Values are: ProductAttributeBased â€”Sorts by product attribute fields. ProductBased â€”Sorts by product field data. Relevancy â€”Sorts by product and catalog term frequency. SortByPricebook â€”Sorts by product prices defined in the specified pricebook (version 55.0 and later).
   */
  global ConnectApi.CommerceSearchSortRuleType type;

  global Object clone() {}

}