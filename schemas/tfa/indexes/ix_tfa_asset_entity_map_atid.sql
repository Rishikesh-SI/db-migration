-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_tfa_asset_entity_map_atid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_asset_entity_map_atid ON tfa.tfa_asset_entity_map USING btree (asset_type_id);


--
