-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_comment_asset_master
-- Type: TABLE

-- Name: labdms_comment_asset_master; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_comment_asset_master (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    total_reactions numeric,
    total_comments numeric
);


--
