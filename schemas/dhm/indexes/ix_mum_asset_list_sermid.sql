-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_asset_list_sermid
-- Type: INDEX

-- Name: ix_mum_asset_list_sermid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_asset_list_sermid ON dhm.dhm_asset_list USING btree (secondary_entity_role_map_id);


--
