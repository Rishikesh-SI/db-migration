-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labkiyg.labkiyg_seo_data USING btree (asset_id, asset_type_id);


--
