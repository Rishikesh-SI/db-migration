-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labrr_beta_08042024.labrr_seo_data USING btree (asset_id, asset_type_id);


--
