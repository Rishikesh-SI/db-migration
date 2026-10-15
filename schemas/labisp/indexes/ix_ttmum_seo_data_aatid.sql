-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labisp.labisp_seo_data USING btree (asset_id, asset_type_id);


--
