-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_atid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_atid ON labsrk.labsrk_asset_entity_map USING btree (asset_type_id);


--
