-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labgg.labgg_seo_data USING btree (asset_id, asset_type_id);


--
