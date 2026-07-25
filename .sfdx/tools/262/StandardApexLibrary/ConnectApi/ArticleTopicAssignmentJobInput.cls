/**
 * An article and topic assignment job.
 */
global class ArticleTopicAssignmentJobInput {

  global ArticleTopicAssignmentJobInput() {}

  /**
   * Type of operation to perform on articles and topics. Values are: AssignTopicsToArticle â€”Assign topics to articles in a data category. UnassignTopicsFromArticle â€”Unassign topics from articles in a data category.
   */
  global ConnectApi.ArticleTopicJobType operation;

  /**
   * List of topic names to assign to or unassign from articles.
   */
  global ConnectApi.TopicNamesInput topicNames;

  global Object clone() {}

}