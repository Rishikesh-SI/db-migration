-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_asset_list_permid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_permid; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_permid ON labrstg.labrstg_asset_list USING btree (primary_entity_role_map_id);


--
