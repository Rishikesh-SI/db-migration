-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labisl_v1.labisl_v1_seo_data USING btree (asset_id, asset_type_id);


--
