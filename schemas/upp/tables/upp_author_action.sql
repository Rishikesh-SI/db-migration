-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_author_action
-- Type: TABLE

-- Name: upp_author_action; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    action_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
