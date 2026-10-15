-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labirao; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labirao.labirao_asset_list USING btree (secondary_entity_role_map_id);


--
