-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_seo_data_aatid
-- Type: INDEX

-- Name: ix_hsl_seo_data_aatid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_seo_data_aatid ON hsl.hsl_seo_data USING btree (asset_id, asset_type_id);


--
