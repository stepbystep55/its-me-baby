CREATE TABLE USER_MASTER (
	ID Integer not null,
	EMAIL varchar(128) not null,
	CRYPTO_PASSWORD varchar(32) not null,
	NAME varchar(32) not null,
	PROFILE varchar(2048) not null,
	primary key (USER_ID));
CREATE UNIQUE INDEX USER_EMAIL_IDX ON USER(EMAIL);