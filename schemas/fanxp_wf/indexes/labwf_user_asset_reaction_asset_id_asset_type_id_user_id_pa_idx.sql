-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_user_asset_reaction_asset_id_asset_type_id_user_id_pa_idx
-- Type: INDEX

-- Name: labwf_user_asset_reaction_asset_id_asset_type_id_user_id_pa_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_user_asset_reaction_asset_id_asset_type_id_user_id_pa_idx ON fanxp_wf.labwf_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
