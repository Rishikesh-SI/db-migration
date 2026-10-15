-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: asset_id_asset_type_id
-- Type: INDEX

-- Name: asset_id_asset_type_id; Type: INDEX; Schema: labecn_v1; Owner: -
--

CREATE INDEX asset_id_asset_type_id ON labecn_v1.labecn_v1_asset_list USING btree (asset_id, asset_type_id);


--
