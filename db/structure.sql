--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cards (
    id integer NOT NULL,
    number integer
);


--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cards_id_seq OWNED BY cards.id;


--
-- Name: mucus_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mucus_types (
    id integer NOT NULL,
    symbol text NOT NULL,
    fertile boolean DEFAULT false NOT NULL,
    peak_type boolean DEFAULT false NOT NULL
);


--
-- Name: mucus_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mucus_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mucus_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mucus_types_id_seq OWNED BY mucus_types.id;


--
-- Name: record_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE record_types (
    id integer NOT NULL,
    name text NOT NULL,
    code text NOT NULL
);


--
-- Name: record_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE record_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: record_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE record_types_id_seq OWNED BY record_types.id;


--
-- Name: records; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE records (
    id integer NOT NULL,
    card_id integer NOT NULL,
    date date NOT NULL,
    type_id integer NOT NULL,
    bleeding_type text,
    peak_day integer,
    mucus_type_id integer,
    frequency integer,
    details text
);


--
-- Name: records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE records_id_seq OWNED BY records.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    filename text NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email text NOT NULL,
    encrypted_password text DEFAULT ''::text NOT NULL,
    reset_password_token text,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip text,
    last_sign_in_ip text,
    authentication_token text,
    is_admin boolean DEFAULT false NOT NULL,
    confirmation_token text,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cards ALTER COLUMN id SET DEFAULT nextval('cards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mucus_types ALTER COLUMN id SET DEFAULT nextval('mucus_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY record_types ALTER COLUMN id SET DEFAULT nextval('record_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY records ALTER COLUMN id SET DEFAULT nextval('records_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: mucus_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mucus_types
    ADD CONSTRAINT mucus_types_pkey PRIMARY KEY (id);


--
-- Name: record_types_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY record_types
    ADD CONSTRAINT record_types_name_key UNIQUE (name);


--
-- Name: record_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY record_types
    ADD CONSTRAINT record_types_pkey PRIMARY KEY (id);


--
-- Name: records_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: users_confirmation_token_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_confirmation_token_key UNIQUE (confirmation_token);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: records_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_card_id_fkey FOREIGN KEY (card_id) REFERENCES cards(id);


--
-- Name: records_mucus_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_mucus_type_id_fkey FOREIGN KEY (mucus_type_id) REFERENCES mucus_types(id);


--
-- Name: records_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_type_id_fkey FOREIGN KEY (type_id) REFERENCES record_types(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;
INSERT INTO "schema_migrations" ("filename") VALUES ('20150711214223_create_cards.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20150712192403_create_records.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20150712201138_change_mucus_types_rename_column_fortile.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20150822195932_add_details_to_record.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20150827191040_create_users.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20150901194549_add_comfirmable_to_users.rb');