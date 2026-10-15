-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: ix_ttmum_webstory_asset_map_aid
-- Type: INDEX

-- Name: ix_ttmum_webstory_asset_map_aid; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX ix_ttmum_webstory_asset_map_aid ON labwis.labwis_webstory_asset_map USING btree (webstory_id);


--
