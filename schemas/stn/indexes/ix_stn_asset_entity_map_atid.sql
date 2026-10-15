-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_stn_asset_entity_map_atid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_entity_map_atid ON stn.stn_asset_entity_map USING btree (asset_type_id);


--
