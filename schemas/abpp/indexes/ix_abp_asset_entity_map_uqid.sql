-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_asset_entity_map_uqid
-- Type: INDEX

-- Name: ix_abp_asset_entity_map_uqid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE UNIQUE INDEX ix_abp_asset_entity_map_uqid ON abpp.abp_asset_entity_map USING btree (asset_id, asset_type_id, entity_role_map_id);


--
