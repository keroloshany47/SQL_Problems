SELECT COUNT(*) AS policy_holder_count
FROM (
    SELECT policy_holder_id
    FROM callers
    GROUP BY policy_holder_id
    HAVING COUNT(*) >=  3 
) AS sub;
