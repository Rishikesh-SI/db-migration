-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_asset_list_sermid
-- Type: INDEX

-- Name: ix_tcs_asset_list_sermid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_asset_list_sermid ON tcs.tcs_asset_list USING btree (secondary_entity_role_map_id);


--
