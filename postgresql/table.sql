{
"name": "Sheikh Aman",
"username": "s.aman@code5.org",
}

*************************************************************************************************************************************
sudo psql -U postgres -h 172.17.0.1

*************************************************************************************************************************************
                                    /* for badge lambda */

create database badge;

/****creating table employee***/

create table employee(
    email varchar(225) primary key,
    emp_name varchar(225),
    role_id serial
);

/*******creating table emp_badge********/

create table hcm_comment_comment(
    comment_id serial,
    badge_sender varchar(225),
    badge_reciver varchar(225),created_at 
    timestamp default now(), 
    comment text ,
    badge_id integer, 
    status boolean default true, 
    updated_at timestamp default now(), 
    FOREIGN KEY (badge_id) references badge(badge_id)
);

/*******creating table badge **********/
create table hcm_badge_badge(
    badge_id serial,
    badge_name varchar(255),
    status boolean default true,
    primary key(badge_id)
    );





                                  /*for training and question lambda*/


/*table for storing answer*/
create table hcm_Training_answer(
    answer_id serial,
    email varchar(225),
    answer jsonb , 
    status boolean default true, 
    created_at timestamp default now() 
    );

/*table for storing category*/

create table hcm_Training_cat_subcat_category(
    cat_id serial, 
    cat_name varchar(225), 
    description text, 
    status boolean default true, 
    primary key(cat_id)
    );

/*table for storing hcm_Training_cat_subcat_sub_category*/

create table hcm_Training_cat_subcat_sub_category(
    sub_id serial, 
    sub_name varchar(225), 
    category_id integer, 
    description text, 
    status boolean default true, 
    foreign key(category_id) references hcm_Training_cat_subcat_category(cat_id)
    );

/*table for storing course*/

create table hcm_Training_lecture_course(
    course_id serial, 
    course_name varchar(225),
    sub_id integer, 
    description text, 
    status boolean default true, 
    primary key (course_id), 
    foreign key(sub_id) references hcm_Training_cat_subcat_sub_category(sub_id) 
    );





/*table for storing lecture */
create table hcm_Training_lecture_lecture(
    lecture_id serial, 
    lecture_name varchar(225), 
    reference text, 
    course_id integer, 
    description text,  
    status boolean default true, 
    foreign key (course_id) references course(course_id) 
    );

/*table for tracking lecture*/

create table hcm_Training_lecture_lect_track(
    email varchar(225), 
    start_date timestamp default true(), 
    lecture_id integer, 
    foreign key(lecture_id) references lecture(lecture_id)
    );


/*table tracking course taken by user*/

create table hcm_Training_user_course(
    email varchar(225), 
    course_id integer, 
    start_date timestamp default now(),
    end_date timestamp default now(), 
    status boolean default true, 
    score integer,
    foreign key(course_id) references course(course_id)
    );



/*table for storing question */

create table hcm_Training_question(
    question_id serial, 
    select_id integer, 
    question text, 
    status boolean default true, 
    created timestamp default now(), 
    updated_at timestamp now(), 
    created_by varchar(225)
    );



/*alter course table 2021-01-6*/
alter table hcm_Training_lecture_course add column image_url text;

/*alter hcm_Training_cat_subcat_sub_category table 2021-01-6*/
alter table hcm_Training_cat_subcat_sub_category add column image_url text;

/*alter category table 2021-01-6*/
alter table hcm_Training_cat_subcat_category add column image_url text;

/*alter table badge 2021-1-8*/
alter table hcm_badge_badge add column image_url text;

/*alter table badge 2021-1-8*/
alter table badge_map add column status boolean default true;

/*alter table badge 2021-1-8*/
alter table hcm_comment_comment rename to comment;

/*alter table badge 2021-1-8*/
alter table hcm_comment_comment rename status to active;

/*alter table user_course 2021-1-9*/
alter table hcm_Training_user_course add column user_courseId serial;

/*alter table question 2021-1-10*/
alter table hcm_Training_question add column course_id integer;

/*alter table question 2021-1-10*/
alter table hcm_Training_question add column lecture_id integer;


alter table hcm_Training_question drop column lecture_id integer;


alter table hcm_comment_comment add column status boolean default true;



alter table hcm_badge_badge add column visibility boolean default true;