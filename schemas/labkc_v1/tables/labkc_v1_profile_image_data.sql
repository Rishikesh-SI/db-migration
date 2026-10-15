-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_profile_image_data
-- Type: TABLE

-- Name: labkc_v1_profile_image_data; Type: TABLE; Schema: labkc_v1; Owner: -
--

CREATE TABLE labkc_v1.labkc_v1_profile_image_data (
    data_id numeric NOT NULL,
    client_code text,
    user_guid text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
