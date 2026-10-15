-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_user_asset_deleted_comments
-- Type: TABLE

-- Name: labmi_v1_user_asset_deleted_comments; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_user_asset_deleted_comments (
    comment_id numeric,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    comment_text text,
    comment_date timestamp without time zone,
    parent_comment_id numeric,
    is_reply_to numeric,
    created_date timestamp without time zone,
    option character(1),
    source character(1)
);


--
