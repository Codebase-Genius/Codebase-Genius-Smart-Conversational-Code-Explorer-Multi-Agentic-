edge calls {
    has count: int = 1;  // Number of times caller invokes callee
}

edge uses {}

edge references {}

edge defines {
    has source: str;
    has created_at: str;
}

edge calls {
    has count: int = 1;
    has confidence: float = 1.0;
}