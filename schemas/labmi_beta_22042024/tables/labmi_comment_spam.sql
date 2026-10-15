-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_comment_spam
-- Type: TABLE

-- Name: labmi_comment_spam; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_comment_spam (
    comment_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    reported_by numeric,
    remarks text
);


--
