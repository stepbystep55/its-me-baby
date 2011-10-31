CREATE TABLE USER_MASTER (
	ID Integer not null,
	EMAIL varchar(128) not null,
	CRYPTO_PASSWORD varchar(32) not null,
	NAME varchar(32) not null,
	PROFILE varchar(2048),
	primary key (ID));
CREATE UNIQUE INDEX USER_EMAIL_IDX ON USER_MASTER(EMAIL);