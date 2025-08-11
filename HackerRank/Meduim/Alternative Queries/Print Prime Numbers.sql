WITH RECURSIVE numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n + 1 <= 1000
),
primes AS (
    SELECT n
    FROM numbers AS outer_num
    WHERE NOT EXISTS (
        SELECT 1
        FROM numbers AS inner_num
        WHERE inner_num.n < outer_num.n
          AND inner_num.n > 1
          AND MOD(outer_num.n, inner_num.n) = 0
    )
)
SELECT GROUP_CONCAT(n SEPARATOR '&') AS prime_numbers
FROM primes;
