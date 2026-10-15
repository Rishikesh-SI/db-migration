-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labstmp.labstmp_seo_data USING btree (asset_id, asset_type_id);


--
