-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_comment_spam
-- Type: TABLE

-- Name: labmi_v1_comment_spam; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_comment_spam (
    comment_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    reported_by numeric,
    remarks text
);


--
