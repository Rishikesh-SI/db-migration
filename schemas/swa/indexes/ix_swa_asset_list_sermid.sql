-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_list_sermid
-- Type: INDEX

-- Name: ix_swa_asset_list_sermid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_asset_list_sermid ON swa.swa_asset_list USING btree (secondary_entity_role_map_id);


--
