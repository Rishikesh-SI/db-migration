-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_asset_list_permid
-- Type: INDEX

-- Name: ix_swa_asset_list_permid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_swa_asset_list_permid ON swa.swa_asset_list USING btree (primary_entity_role_map_id);


--
