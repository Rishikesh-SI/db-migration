-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_poll_option_300922
-- Type: TABLE

-- Name: labmcfc_v1_poll_option_300922; Type: TABLE; Schema: labmcfc_v1; Owner: -
--

CREATE TABLE labmcfc_v1.labmcfc_v1_poll_option_300922 (
    poll_option_id numeric,
    poll_id numeric,
    option character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    poll_option_guid character varying(256),
    option_order numeric,
    is_ans numeric
);


--
