-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_mentor_mapping
-- Type: TABLE

-- Name: labbsc_dev_user_mentor_mapping; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_mentor_mapping (
    user_mentor_id numeric NOT NULL,
    user_id numeric,
    mentor_id numeric,
    cart_id numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
