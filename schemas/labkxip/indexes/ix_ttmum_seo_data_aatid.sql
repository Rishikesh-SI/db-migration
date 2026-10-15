-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labkxip.labkxip_seo_data USING btree (asset_id, asset_type_id);


--
