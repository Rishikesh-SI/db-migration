-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: ix_ttmum_webstory_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_webstory_asset_map_aid; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX ix_ttmum_webstory_asset_map_aid ON labgt01_v1.labgt01_v1_webstory_asset_map USING btree (webstory_id);


--
