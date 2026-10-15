-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_seo_data_aatid
-- Type: INDEX

-- Name: ix_hsl_seo_data_aatid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_seo_data_aatid ON labhsl.labhsl_seo_data USING btree (asset_id, asset_type_id);


--
