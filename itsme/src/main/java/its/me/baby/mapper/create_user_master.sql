CREATE TABLE USER_MASTER (
	ID Integer not null,
	EMAIL varchar(128) not null,
	CRYPTO_PASSWORD varchar(32) not null,
	primary key (ID));
CREATE UNIQUE INDEX USER_EMAIL_IDX ON USER_MASTER(EMAIL);