-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON labdsg.labdsg_asset_entity_map USING btree (asset_id);


--
