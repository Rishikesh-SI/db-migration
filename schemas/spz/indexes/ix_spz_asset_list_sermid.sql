-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_asset_list_sermid
-- Type: INDEX

-- Name: ix_spz_asset_list_sermid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_asset_list_sermid ON spz.spz_asset_list USING btree (secondary_entity_role_map_id);


--
