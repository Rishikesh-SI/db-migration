-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_asset_reaction_summary
-- Type: TABLE

-- Name: labmi_asset_reaction_summary; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_asset_reaction_summary (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    latest_comments numeric[],
    total_reactions numeric,
    total_comments numeric
);


--
