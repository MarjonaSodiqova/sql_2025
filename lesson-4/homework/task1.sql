CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);


SELECT *
FROM dbo.TestMultipleZero
WHERE NOT (
    ISNULL(A, 0) = 0 AND 
    ISNULL(B, 0) = 0 AND 
    ISNULL(C, 0) = 0 AND 
    ISNULL(D, 0) = 0
);
