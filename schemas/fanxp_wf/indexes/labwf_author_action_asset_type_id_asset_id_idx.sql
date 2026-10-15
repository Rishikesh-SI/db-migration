-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_author_action_asset_type_id_asset_id_idx
-- Type: INDEX

-- Name: labwf_author_action_asset_type_id_asset_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_author_action_asset_type_id_asset_id_idx ON fanxp_wf.labwf_author_action USING btree (asset_type_id, asset_id);


--
