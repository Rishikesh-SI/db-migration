-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_asset_list_aidatid
-- Type: INDEX

-- Name: ix_spz_asset_list_aidatid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_asset_list_aidatid ON spz.spz_asset_list USING btree (asset_id, asset_type_id);


--
