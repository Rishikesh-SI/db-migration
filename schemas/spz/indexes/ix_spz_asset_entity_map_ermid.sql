-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_asset_entity_map_ermid
-- Type: INDEX

-- Name: ix_spz_asset_entity_map_ermid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_asset_entity_map_ermid ON spz.spz_asset_entity_map USING btree (entity_role_map_id);


--
