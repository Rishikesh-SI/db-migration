-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_asset_list_aidatid
-- Type: INDEX

-- Name: ix_mum_asset_list_aidatid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_asset_list_aidatid ON tmm.tmm_asset_list USING btree (asset_id, asset_type_id);


--
