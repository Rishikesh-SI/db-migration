-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_asset_list_asset_type_id_idx
-- Type: INDEX

-- Name: labwf_asset_list_asset_type_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_asset_list_asset_type_id_idx ON fanxp_wf.labwf_asset_list USING btree (asset_type_id);


--
