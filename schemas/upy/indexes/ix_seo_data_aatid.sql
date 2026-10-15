-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_seo_data_aatid
-- Type: INDEX

-- Name: ix_seo_data_aatid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_seo_data_aatid ON upy.upy_seo_data USING btree (asset_id, asset_type_id);


--
