-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labtkr_beta.labtkr_seo_data USING btree (asset_id, asset_type_id);


--
