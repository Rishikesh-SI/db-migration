-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_seo_data_aatid
-- Type: INDEX

-- Name: ix_isl_seo_data_aatid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_seo_data_aatid ON isl.isl_seo_data USING btree (asset_id, asset_type_id);


--
