drop table mp_bid;
drop table mp_user;
drop table mp_veh;
drop table mp_veh_img;
drop sequence seq_mp_user;
drop sequence seq_mp_veh;
create table mp_user(                              
  id_user number(4) constraint pk_user primary key,
  role varchar2(7) default 'user' constraint ck_role check(role in ('manager','user')),
  username varchar2(20) not null unique,
  password varchar2(20) not null,
  org nvarchar2(30),
  tel number(11),
  email varchar2(30),
  user_stamp timestamp(0) default sysdate,
  confirm number(1) default 0 constraint ck_confirm check(confirm in (1,0)),
  follow varchar2(2000) default ' '
);
create table mp_veh(
  id_veh number(10) constraint pk_veh primary key,
  batch_num varchar2(14) default to_char(sysdate,'yyyymmddhh24miss'),
  license_num varchar2(7) not null unique,
  veh_id_num varchar2(17) not null unique,
  engine_num varchar2(8) not null unique,
  brand nvarchar2(20) not null,
  brand_model nvarchar2(20) not null,
  intro nvarchar2(100) not null,
  veh_stamp timestamp(0) default sysdate,
  start_bid_time timestamp(0),
  expir_bid_time timestamp(0),
  expir_pay_time timestamp(0),
  start_price number(7,-3),
  curr_price number(7,-3),
  remark nvarchar2(100),
  veh_state number(1) default 0 constraint ck_veh_state check(veh_state in (0,1,2))
);
create table mp_veh_img(
  id_veh number(10) unique,
  img0 blob,
  img1 blob,
  img2 blob,
  img3 blob,
  img4 blob,
  img5 blob,
  constraint fk_veh_img foreign key(id_veh) references mp_veh(id_veh) on delete cascade
);
create table mp_bid(
  id_user number(4),
  id_veh number(10),
  bid_price number(7,-3),
  bid_stamp timestamp(0) default sysdate,
  constraint fk_bid_user foreign key(id_user) references mp_user(id_user) on delete cascade,
  constraint fk_bid_veh foreign key(id_veh) references mp_veh(id_veh) on delete cascade
);

create sequence seq_mp_user                                
maxvalue 1E4
nocache;

create sequence seq_mp_veh								   
maxvalue 1E10
nocache;

create or replace trigger tri_mp_user_id_user			
  before insert on mp_user
  for each row
begin
  select seq_mp_user.nextval into :new.id_user from dual;
end;
/
create or replace trigger tri_mp_veh_id_veh            
  before insert on mp_veh
  for each row
begin
  select seq_mp_veh.nextval into :new.id_veh from dual;
end;
/
create or replace trigger tri_mp_veh_img_insert     
  after insert on mp_veh
  for each row
begin
  insert into mp_veh_img(id_veh) values(:new.id_veh);
end;
/
create or replace trigger tri_mp_veh_curr_price     
  after insert or update of bid_price on mp_bid
  for each row
begin
  update mp_veh set curr_price = :new.bid_price where id_veh = :new.id_veh;
end;
/
exit