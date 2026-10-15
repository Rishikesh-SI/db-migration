-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_asset_reaction_summary
-- Type: TABLE

-- Name: labmi_v1_asset_reaction_summary; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_asset_reaction_summary (
    asset_id numeric,
    asset_type_id numeric,
    latest_comments numeric[],
    total_reactions numeric,
    total_comments numeric
);


--
