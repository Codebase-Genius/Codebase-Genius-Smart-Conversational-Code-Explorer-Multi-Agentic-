// Defines the ConversationalAgent archetype.
architype ConversationalAgent {
    // It has the ability to handle a query.
    // We assume the entity name is extracted from the query for now.
    can handle_query with query: str, entity_name: str;
}