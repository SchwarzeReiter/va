drop sequence if exists doctor_id_seq cascade;
drop sequence if exists patient_id_seq cascade;
drop sequence if exists vaccine_sequence cascade;
drop sequence if exists dose_template_sequence cascade;
drop table if exists patient cascade;
drop table if exists doctor cascade;
drop table if exists patient_vaccine cascade;
drop table if exists vaccine cascade;
drop table if exists dose_template cascade;
drop table if exists patient_dose cascade;



create table if not exists doctor
(
    id          bigserial primary key,
    email       varchar(255) not null,
    password    varchar(255) not null,
    first_name  varchar(255) not null,
    second_name varchar(255) not null,
    delete      bool         not null default false
);

create table if not exists patient
(
    id           bigserial primary key,
    med_id       varchar(255),
    first_name   varchar(255) not null,
    second_name  varchar(255) not null,
    birthday     date         not null,
    phone_number integer      not null,
    deleted      boolean      not null default false,
    doctor_id    bigint       not null,
    constraint fk_doctor foreign key (doctor_id)
        references doctor (id)
);

create table if not exists patient_vaccine
(
    patient_id bigint not null,
    vaccine_id bigint not null,
    unique (patient_id, vaccine_id)
);

create table if not exists vaccine
(
    id     bigint primary key,
    name   varchar(255) not null,
    med_id varchar(255)
);
create sequence vaccine_sequence start 1 increment 50;

create table if not exists dose_template
(
    id          bigint primary key,
    number      smallint not null,
    au_ml       decimal,
    day_of_life bigint   not null,
    vaccine_id  bigint   not null
);
create sequence dose_template_sequence start 1 increment 50;

create table if not exists patient_dose
(
    patient_id bigint not null,
    dose_id    bigint not null,
    date       date   not null,
    status     bool   not null default false
);