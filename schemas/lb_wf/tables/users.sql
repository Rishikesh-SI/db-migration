-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: users
-- Type: TABLE

-- Name: users; Type: TABLE; Schema: lb_wf; Owner: -
--

CREATE TABLE lb_wf.users (
    id integer DEFAULT nextval('lb_wf.users_id_seq'::regclass) NOT NULL,
    email text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    is_deleted boolean DEFAULT false
);


--
