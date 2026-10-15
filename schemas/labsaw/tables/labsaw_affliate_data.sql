-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_affliate_data
-- Type: TABLE

-- Name: labsaw_affliate_data; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_affliate_data (
    affliate_data_id numeric NOT NULL,
    affliate_id numeric,
    affliate_name character varying,
    affiliate_signup numeric,
    affiliate_deposit numeric,
    affiliate_account_no character varying,
    user_guid character varying,
    created_date timestamp without time zone,
    is_approved numeric,
    affliate_json json,
    is_send numeric
);


--
