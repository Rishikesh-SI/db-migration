-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_user_asset_reaction_asset_id_asset_type_id_user_id_p_idx
-- Type: INDEX

-- Name: lablsg_user_asset_reaction_asset_id_asset_type_id_user_id_p_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_user_asset_reaction_asset_id_asset_type_id_user_id_p_idx ON fanxp_lsg.lablsg_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
