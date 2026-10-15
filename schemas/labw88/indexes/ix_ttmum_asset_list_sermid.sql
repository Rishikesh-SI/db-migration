-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON labw88.labw88_asset_list USING btree (secondary_entity_role_map_id);


--
