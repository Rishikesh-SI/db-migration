-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_asset_comment_count_view
-- Type: MATERIALIZED VIEW

-- Name: labyho_asset_comment_count_view; Type: MATERIALIZED VIEW; Schema: labyho; Owner: -
--

CREATE MATERIALIZED VIEW labyho.labyho_asset_comment_count_view AS
 SELECT labyho_user_asset_reaction.asset_id,
    labyho_user_asset_reaction.asset_type_id,
    count(1) AS comments_count
   FROM labyho.labyho_user_asset_reaction
  WHERE (labyho_user_asset_reaction.reaction_id = (4)::numeric)
  GROUP BY labyho_user_asset_reaction.asset_id, labyho_user_asset_reaction.asset_type_id
  WITH NO DATA;


--
