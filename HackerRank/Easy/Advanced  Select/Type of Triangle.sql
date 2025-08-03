SELECT 
    CASE 
        -- First check if it's a valid triangle (triangle inequality theorem)
        -- Sum of any two sides must be greater than the third side
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
                -- If valid triangle, classify by side lengths
        WHEN A = B AND B = C THEN 'Equilateral'  -- All three sides equal
        WHEN A = B OR B = C OR A = C THEN 'Isosceles'  -- Two sides equal
        ELSE 'Scalene'  -- All sides different
    END AS triangle_type
FROM TRIANGLES;
