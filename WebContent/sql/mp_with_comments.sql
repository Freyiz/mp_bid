drop table mp_bid;
drop table mp_user;
drop table mp_veh;
drop table mp_veh_img;
drop sequence seq_mp_user;
drop sequence seq_mp_veh;
create table mp_user(                               --用户表
  id_user number(4) constraint pk_user primary key, --用户id,主键
  role varchar2(7) default 'user' constraint ck_role check(role in ('manager','user')), 
  													--用户角色，包括：manager,user       
  username varchar2(20) not null unique,            --用户名     
  password varchar2(20) not null,                   --密码     
  org nvarchar2(30),                                --公司      
  tel number(11),                                   --电话
  email varchar2(30),                               --邮箱      
  user_stamp timestamp(0) default sysdate,          --创建时间
  confirm number(1) default 0 constraint ck_confirm check(confirm in (1,0)),			
  													--审核情况，包括：1--通过审核，0--未通过审核，由管理员修改
  follow varchar2(2000)                             --关注车辆，存储关注的车辆id，类似‘id1 id2 id3’
                                                       --查询：select * from mp_veh where (select follow from mp_user where id_user=?) like '%||id_veh||%'
                                                       --加入关注：update mp_user set follow=concat(follow,?||' ')
                                                       --取消关注：update mp_user set follow=replace(follow,id_veh||' ','')                    
);
create table mp_veh(                                 --车辆表
  id_veh number(10) constraint pk_veh primary key,   --车辆id，主键
  batch_num varchar2(14) default to_char(sysdate,'yyyymmddhh24miss'), 					
  													 --车辆批次       
  license_num varchar2(7) not null unique,           --车牌号     
  veh_id_num varchar2(17) not null unique,           --车架码     
  engine_num varchar2(8) not null unique,            --发动机编号      
  brand nvarchar2(10) not null,                      --品牌
  brand_model nvarchar2(10) not null,                --车系      
  intro nvarchar2(100) not null,					 --简介，用于记录车辆各项指标及使用情况
  veh_stamp timestamp(0) default sysdate,            --导入时间
  start_bid_time timestamp(0),                       --加入拍卖时间 
  expir_bid_time timestamp(0),                       --拍卖到期时间，等于加入拍卖时间 + 持续时间，可选：3天，5天，7天
  expir_pay_time timestamp(0),                       --付款到期时间，等于拍卖到期时间 + 付款期限，可选：3天，5天，7天
  start_price number(7,-3),                          --起拍价
  curr_price number(7,-3),                           --现价，用户出价成功后由触发器更新,
  remark nvarchar2(100),                             --备注，用于记录延期付款、交易取消等信息，由管理员修改
  veh_state number(1) default 0 constraint ck_veh_state check(veh_state in (0,1,2))      
  													 --车辆状态，包括：0--未付款，1--已付款，2--已交车，由管理员修改
  													 	--其中未付款包括以下五种情况：新入库、预拍、拍卖中、拍卖到期、待付款
);
create table mp_veh_img(							 --车辆实图表
  id_veh number(10) unique,							 --车辆id，外键 
  img0 blob,										 --图一
  img1 blob,										 --图二	
  img2 blob,										 --图三
  img3 blob,										 --图四
  img4 blob,										 --图五
  img5 blob,										 --图六
  constraint fk_veh_img foreign key(id_veh) references mp_veh(id_veh) on delete cascade
);
create table mp_bid(                                 --竞拍表，用于记录用户出价信息，同一用户对同一车辆出价时更新bid_price，对不同车辆出价时插入新数据
  id_user number(4),                                 --用户id，外键
  id_veh number(10),                                 --车辆id，外键       
  bid_price number(7,-3),                            --竞拍价，同一车辆可能存在多个竞拍价，其中最高者即为车辆现价
  bid_stamp date timestamp(0) sysdate,               --竞拍时间                            
  constraint fk_bid_user foreign key(id_user) references mp_user(id_user) on delete cascade,
  constraint fk_bid_veh foreign key(id_user) references mp_veh(id_veh) on delete cascade
);
comment on column mp_user.id_user is '用户ID，主键';
comment on column mp_user.role is '角色，包括：manager,user';
comment on column mp_user.username is '用户名';
comment on column mp_user.password is '密码';
comment on column mp_user.org is '公司';
comment on column mp_user.tel is '电话';
comment on column mp_user.email is '邮箱';
comment on column mp_user.user_stamp is '创建时间';
comment on column mp_user.confirm is '审核情况，包括：1--通过审核，0--未通过审核';
comment on column mp_user.follow is '关注车辆，存储关注的车辆id,比如"id1 id2"';
comment on column mp_veh.id_veh is '车辆ID，主键';
comment on column mp_veh.batch_num is '车辆批次';
comment on column mp_veh.license_num is '车牌号';
comment on column mp_veh.veh_id_num is '车架码';
comment on column mp_veh.engine_num is '发动机号';
comment on column mp_veh.brand is '品牌';
comment on column mp_veh.brand_model is '车系';
comment on column mp_veh.intro is '简介，用于记录车辆各项指标及使用情况';
comment on column mp_veh.veh_stamp is '导入时间';
comment on column mp_veh.start_bid_time is '加入拍卖时间';
comment on column mp_veh.expir_bid_time is '拍卖到期时间';
comment on column mp_veh.expir_pay_time is '付款到期时间';
comment on column mp_veh.start_price is '起拍价';
comment on column mp_veh.curr_price is '现价，用户出价成功后由触发器更新';
comment on column mp_veh.remark is '备注，用于记录延期付款、交易取消等信息';
comment on column mp_veh.veh_state is '车辆状态，包括：0--正常，1--已付款，2--已交车';
comment on column mp_veh_img.id_veh is '车辆ID，外键';
comment on column mp_veh_img.img0 is '图一';
comment on column mp_veh_img.img1 is '图二';
comment on column mp_veh_img.img2 is '图三';
comment on column mp_veh_img.img3 is '图四';
comment on column mp_veh_img.img4 is '图五';
comment on column mp_veh_img.img5 is '图六';
comment on column mp_bid.id_user is '用户ID，外键';
comment on column mp_bid.id_veh is '车辆ID，外键';
comment on column mp_bid.bid_price is '竞拍价，同一车辆可能存在多个竞拍价，其中最高者即为车辆现价';
comment on column mp_bid.bid_stamp is '竞拍时间';

create sequence seq_mp_user                                
maxvalue 1E4
nocache;

create sequence seq_mp_veh								   
maxvalue 1E10
nocache;

create or replace trigger tri_mp_user_id_user			   --自动生成id_user
  before insert on mp_user
  for each row
begin
  select seq_mp_user.nextval into :new.id_user from dual;
end;
/
create or replace trigger tri_mp_veh_id_veh                --自动生成id_veh
  before insert on mp_veh
  for each row
begin
  select seq_mp_veh.nextval into :new.id_veh from dual;
end;
/
create or replace trigger tri_mp_veh_img_insert     	   --当mp_veh插入数据时插入数据
  after insert on mp_veh
  for each row
begin
  insert into mp_veh_img(id_veh) values(:new.id_veh);
end;
/
create or replace trigger tri_mp_veh_curr_price            --当mp_bid插入数据或更新列bid_price时自动更新mp_veh.curr_price
  after insert or update of bid_price on mp_bid
  for each row
begin
  update mp_veh set curr_price = :new.bid_price where id_veh = :new.id_veh;
end;
/
exit