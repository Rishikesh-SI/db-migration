-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_ttmum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_atid; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_atid ON labukk.labukk_asset_entity_map USING btree (asset_type_id);


--
