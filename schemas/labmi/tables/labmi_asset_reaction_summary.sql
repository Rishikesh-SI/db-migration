-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_asset_reaction_summary
-- Type: TABLE

-- Name: labmi_asset_reaction_summary; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_asset_reaction_summary (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    latest_comments numeric[],
    total_reactions numeric,
    total_comments numeric
);


--
