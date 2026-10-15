-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_seo_data_aatid
-- Type: INDEX

-- Name: ix_zeven_seo_data_aatid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_seo_data_aatid ON zeven.zeven_seo_data USING btree (asset_id, asset_type_id);


--
