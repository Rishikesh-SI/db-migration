-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_seo_data_aatid
-- Type: INDEX

-- Name: ix_tcs_seo_data_aatid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_seo_data_aatid ON tcs.tcs_seo_data USING btree (asset_id, asset_type_id);


--
