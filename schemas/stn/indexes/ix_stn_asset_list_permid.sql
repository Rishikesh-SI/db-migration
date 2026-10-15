-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_list_permid
-- Type: INDEX

-- Name: ix_stn_asset_list_permid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_list_permid ON stn.stn_asset_list USING btree (primary_entity_role_map_id);


--
