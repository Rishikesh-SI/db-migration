-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_list_permid
-- Type: INDEX

-- Name: ix_ppb_asset_list_permid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_list_permid ON ppb.ppb_asset_list USING btree (primary_entity_role_map_id);


--
