create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

-- b first
SELECT letter
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 0 ELSE 1 END,
    letter;
-- b last
SELECT letter
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 1 ELSE 0 END,
    letter;
-- b in 3rd 
WITH Ranked AS (
    SELECT letter, 
           ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
    WHERE letter <> 'b'
),
Final AS (
    SELECT letter FROM Ranked WHERE rn < 2
    UNION ALL
    SELECT 'b'
    UNION ALL
    SELECT letter FROM Ranked WHERE rn >= 2
)
SELECT * FROM Final;

