-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_asset_list_permid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_permid; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_permid ON labrs_2602.labrs_asset_list USING btree (primary_entity_role_map_id);


--
