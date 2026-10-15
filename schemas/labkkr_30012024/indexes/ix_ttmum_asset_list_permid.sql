-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: ix_ttmum_asset_list_permid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_permid; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_permid ON labkkr_30012024.labkkr_asset_list USING btree (primary_entity_role_map_id);


--
