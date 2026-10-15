-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_asset_entity_map_atid
-- Type: INDEX

-- Name: ix_scom_asset_entity_map_atid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_asset_entity_map_atid ON scom.scom_asset_entity_map USING btree (asset_type_id);


--
