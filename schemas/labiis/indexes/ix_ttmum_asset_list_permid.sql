-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: ix_ttmum_asset_list_permid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_permid; Type: INDEX; Schema: labiis; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_permid ON labiis.labiis_asset_list USING btree (primary_entity_role_map_id);


--
