-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_jafc_asset_entity_map_aid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_asset_entity_map_aid ON jafc.jafc_asset_entity_map USING btree (asset_id);


--
