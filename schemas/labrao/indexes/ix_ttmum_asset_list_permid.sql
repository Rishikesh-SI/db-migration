-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_ttmum_asset_list_permid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_permid; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_permid ON labrao.labrao_asset_list USING btree (primary_entity_role_map_id);


--
