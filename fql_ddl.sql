-- ******************** SCRIPT FOR POSTGRESQL  ********************

-- login as user "fql" to the "appbase" database
-- psql -U fql -h 127.0.0.1 appbase

-- or run it from the terminal
-- psql -U fql -h 127.0.0.1 -d appbase -a -f <path_to_this_file>

drop table if exists FQL_RULES;
drop table if exists FQL_DATA;
drop table if exists FQL_FORMS;
drop table if exists FQL_TYPES;

create table FQL_FORMS (
    ID         serial primary key,
    NAME       varchar(63) unique not null,
    TABLE_NAME varchar(63) unique not null
);

create table FQL_TYPES (
    ID   int primary key,
    NAME varchar(63) unique not null
);

insert into FQL_TYPES (ID, NAME) values (0, 'REFERENCE');
insert into FQL_TYPES (ID, NAME) values (1, 'NUMBER');
insert into FQL_TYPES (ID, NAME) values (2, 'TEXT');
insert into FQL_TYPES (ID, NAME) values (3, 'BOOLEAN');
insert into FQL_TYPES (ID, NAME) values (4, 'DATE');
insert into FQL_TYPES (ID, NAME) values (5, 'TIME');
insert into FQL_TYPES (ID, NAME) values (6, 'FILE');
insert into FQL_TYPES (ID, NAME) values (7, 'IMAGE');

create table FQL_DATA (
    ID              serial primary key,
    LABEL           varchar(511) not null,
    COLUMN_NAME     varchar(511),
    FORM_ID         int not null, 
    TYPE_ID         int not null,
    DATA_ORDER      int,
    UNIQUE_DATA     bool,
    NULLABLE        bool not null,
    VISIBLE         bool not null,
    
-- reference related columns
    DATA_ID         int,
    FULL_REF        bool,
    UNIQUE_REF      bool,
    TOTALLY         bool,
    MIN             int,
    MAX             int,

    constraint FORM_ID_ORDER unique (FORM_ID, DATA_ORDER),
    constraint LABEL_FORM_ID_DATA_ID unique  (LABEL, FORM_ID, DATA_ID),

    constraint FK_FORM_ID foreign key (FORM_ID) references FQL_FORMS(ID),
    constraint FK_TYPE_ID foreign key (TYPE_ID) references FQL_TYPES(ID),
    constraint FK_DATA_ID foreign key (DATA_ID) references FQL_DATA(ID)
);

create table FQL_RULES (
    ID              serial primary key,
    FORM_ID         int not null,
    RULE_COMMAND    varchar(511) not null,
    RULE_SERIALIZED bytea not null,

    constraint FK_FORM_ID foreign key (FORM_ID) references FQL_FORMS(ID)
);
