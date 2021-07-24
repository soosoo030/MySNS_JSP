use mysnsdb;

create table `s_member`(
	`name`	varchar(10)		not null,
    `uid`		varchar(10) 	not null,	
    `email`	varchar(20),
    `user_pw`		varchar(15)	not null,
    `date`	datetime	not null,
    PRIMARY KEY (`uid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;	

create table `s_message`(
	`mid`		int(10)		not null AUTO_INCREMENT,
    `uid`		varchar(10)	not null,
    `msg`		varchar(100)	not null,
    `msgtitle` varchar(15)	not null,
    `favcount`	int(10)		default '0',
    `replycount`	int(10)		default '0',
    `date`	datetime	not null,
    PRIMARY KEY (`mid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;	

create table `s_reply`(
	`rid`		int(10)		not null AUTO_INCREMENT,
    `mid`		int(10),
    `uid`		varchar(10)	not null,
    `rmsg`	varchar(50)	not null,
    `date`	datetime	not null,
    `secret` boolean	not null,
    PRIMARY KEY (`rid`),
	KEY `message_FK_idx` (`mid`),
    CONSTRAINT `message_FK` FOREIGN KEY (`mid`) REFERENCES `s_message` (`mid`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;	

create table `s_favorite`(
	`fid`	int(10)	not null AUTO_INCREMENT,
	`uid`	varchar(10) not null,
    `mid` 	int(10)	not null,
    PRIMARY KEY(`fid`),
	CONSTRAINT `fk_s_favorite` FOREIGN KEY (`uid`) REFERENCES `s_member`(`uid`) ON DELETE CASCADE ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8;	
