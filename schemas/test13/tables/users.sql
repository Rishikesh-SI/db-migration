-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test13
-- Object: users
-- Type: TABLE

-- Name: users; Type: TABLE; Schema: test13; Owner: -
--

CREATE TABLE test13.users (
    user_id integer DEFAULT nextval('test13.test13_seq'::regclass) NOT NULL,
    username character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


--
