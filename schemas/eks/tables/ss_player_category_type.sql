-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_player_category_type
-- Type: TABLE

-- Name: ss_player_category_type; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_player_category_type (
    cf_player_categoryid numeric(25,0) NOT NULL,
    category_name character varying(255),
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
