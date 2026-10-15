-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test14
-- Object: users
-- Type: TABLE

-- Name: users; Type: TABLE; Schema: test14; Owner: -
--

CREATE TABLE test14.users (
    user_id integer DEFAULT nextval('test14.test14_seq'::regclass) NOT NULL,
    username character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


--
