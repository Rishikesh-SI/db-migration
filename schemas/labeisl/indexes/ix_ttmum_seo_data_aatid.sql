-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labeisl.labeisl_seo_data USING btree (asset_id, asset_type_id);


--
