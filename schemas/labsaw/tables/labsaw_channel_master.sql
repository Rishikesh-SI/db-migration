-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_channel_master
-- Type: TABLE

-- Name: labsaw_channel_master; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_channel_master (
    channel_id numeric NOT NULL,
    channel_detail jsonb
);


--
