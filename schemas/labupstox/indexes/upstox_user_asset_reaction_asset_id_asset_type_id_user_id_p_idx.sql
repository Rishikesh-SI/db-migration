-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_user_asset_reaction_asset_id_asset_type_id_user_id_p_idx
-- Type: INDEX

-- Name: upstox_user_asset_reaction_asset_id_asset_type_id_user_id_p_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_user_asset_reaction_asset_id_asset_type_id_user_id_p_idx ON labupstox.labupstox_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
