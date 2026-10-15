-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_asset_list_atid
-- Type: INDEX

-- Name: ix_spz_asset_list_atid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_asset_list_atid ON spz.spz_asset_list USING btree (asset_type_id);


--
