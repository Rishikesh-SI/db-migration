-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_channel_master
-- Type: TABLE

-- Name: labstmp_channel_master; Type: TABLE; Schema: labstmp; Owner: -
--

CREATE TABLE labstmp.labstmp_channel_master (
    channel_id numeric NOT NULL,
    channel_detail jsonb
);


--
