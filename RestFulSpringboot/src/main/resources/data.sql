INSERT INTO users(username, password)  VALUES('user' , '$2a$10$vAIaVaw3DgSuIrA0dtBXj.TQdMnc3wfHxJfxGg64qY27IhCHXxpxy');
INSERT INTO users(username, password)  VALUES('admin', '$2a$10$KqH01MajeilHaFdBqPHNLevXO3Y8KRKHZ3UsHINcxvx8.1auEFR1y');
INSERT INTO users(username, password)  VALUES('kakao', '$2a$10$jUJ75xdku7XGHIlnybmHrOHCMIhfeXz8hXQThHmoG0Jay7nZAWv7O');

insert into authority(username, authority_name) values ('pyun' , 'USER');
insert into authority(username, authority_name) values ('admin', 'USER');
insert into authority(username, authority_name) values ('user' , 'USER');


--insert into hist_search(username,keyword) values('kakao','kakaobank');