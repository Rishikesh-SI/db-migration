-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_user_activity
-- Type: TABLE

-- Name: yho_user_activity; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    activity_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
