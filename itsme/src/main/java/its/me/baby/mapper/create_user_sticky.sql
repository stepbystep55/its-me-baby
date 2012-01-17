CREATE TABLE USER_STICKY (
	ID Integer not null,
	USER_ID Integer not null,
	POSITION_TOP Integer not null,
	POSITION_LEFT Integer not null,
	WIDTH Integer not null,
	HEIGHT Integer not null,
	FONT_SIZE Integer not null,
	FONT_COLOR varchar(8) not null,
	TRANSPARENT boolean not null,
	BG_COLOR varchar(8) not null,
	CONTENT varchar(2048),
	primary key (ID),
	FOREIGN KEY (USER_ID) REFERENCES USER_MASTER(ID));