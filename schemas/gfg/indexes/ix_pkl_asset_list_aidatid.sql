-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_asset_list_aidatid
-- Type: INDEX

-- Name: ix_pkl_asset_list_aidatid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_asset_list_aidatid ON gfg.gfg_asset_list USING btree (asset_id, asset_type_id);


--
