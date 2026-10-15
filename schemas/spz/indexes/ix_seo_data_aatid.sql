-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_seo_data_aatid
-- Type: INDEX

-- Name: ix_seo_data_aatid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_seo_data_aatid ON spz.spz_seo_data USING btree (asset_id, asset_type_id);


--
