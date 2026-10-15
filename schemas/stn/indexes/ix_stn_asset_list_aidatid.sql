-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_list_aidatid
-- Type: INDEX

-- Name: ix_stn_asset_list_aidatid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_list_aidatid ON stn.stn_asset_list USING btree (asset_id, asset_type_id);


--
