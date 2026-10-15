-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: labecn_user_activity
-- Type: TABLE

-- Name: labecn_user_activity; Type: TABLE; Schema: labecn_bkp07062024; Owner: -
--

CREATE TABLE labecn_bkp07062024.labecn_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    activity_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
