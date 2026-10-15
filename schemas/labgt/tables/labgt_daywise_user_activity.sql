-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_daywise_user_activity
-- Type: TABLE

-- Name: labgt_daywise_user_activity; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_daywise_user_activity (
    daywise_user_activity_id numeric NOT NULL,
    user_guid character varying(256),
    module_name character varying(4000),
    asset_id numeric,
    asset_type_id numeric,
    is_successful numeric,
    input_json jsonb,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
