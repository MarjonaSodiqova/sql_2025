CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_identity (name) VALUES ('One'), ('Two'), ('Three'), ('Four'), ('Five');

DELETE FROM test_identity;
INSERT INTO test_identity (name) VALUES ('One'), ('Two'), ('Three'), ('Four'), ('Five');

TRUNCATE TABLE test_identity;
INSERT INTO test_identity (name) VALUES ('One'), ('Two'), ('Three'), ('Four'), ('Five');

DROP TABLE test_identity;