-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_asset_list_asset_id_asset_type_id_idx
-- Type: INDEX

-- Name: lablsg_asset_list_asset_id_asset_type_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_asset_list_asset_id_asset_type_id_idx ON fanxp_lsg.lablsg_asset_list USING btree (asset_id, asset_type_id);


--
