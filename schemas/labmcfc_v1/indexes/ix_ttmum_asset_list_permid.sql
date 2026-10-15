-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: ix_ttmum_asset_list_permid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_permid; Type: INDEX; Schema: labmcfc_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_permid ON labmcfc_v1.labmcfc_v1_asset_list USING btree (primary_entity_role_map_id);


--
