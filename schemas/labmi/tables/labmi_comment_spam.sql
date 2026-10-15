-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_comment_spam
-- Type: TABLE

-- Name: labmi_comment_spam; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_comment_spam (
    comment_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    reported_by numeric,
    remarks text
);


--
