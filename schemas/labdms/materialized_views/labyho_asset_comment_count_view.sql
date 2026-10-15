-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labyho_asset_comment_count_view
-- Type: MATERIALIZED VIEW

-- Name: labyho_asset_comment_count_view; Type: MATERIALIZED VIEW; Schema: labdms; Owner: -
--

CREATE MATERIALIZED VIEW labdms.labyho_asset_comment_count_view AS
 SELECT labdms_user_asset_reaction.asset_id,
    labdms_user_asset_reaction.asset_type_id,
    count(1) AS comments_count
   FROM labdms.labdms_user_asset_reaction
  WHERE (labdms_user_asset_reaction.reaction_id = (4)::numeric)
  GROUP BY labdms_user_asset_reaction.asset_id, labdms_user_asset_reaction.asset_type_id
  WITH NO DATA;


--
