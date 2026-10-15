-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_asset_list_permid
-- Type: INDEX

-- Name: ix_tcs_asset_list_permid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_asset_list_permid ON tcs.tcs_asset_list USING btree (primary_entity_role_map_id);


--
