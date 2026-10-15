-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_seo_data_aatid
-- Type: INDEX

-- Name: ix_abp_seo_data_aatid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_seo_data_aatid ON abpp.abp_seo_data USING btree (asset_id, asset_type_id);


--
