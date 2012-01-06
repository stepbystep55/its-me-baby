CREATE TABLE USER_STICKY (
	ID Integer not null,
	USER_ID Integer not null,
	POSITON_TOP Integer not null,
	POSITON_LEFT Integer not null,
	CONTENT varchar(2048),
	primary key (ID),
	FOREIGN KEY (USER_ID) REFERENCES USER_MASTER(ID));