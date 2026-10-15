-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_seo_data_aatid
-- Type: INDEX

-- Name: ix_pkl_seo_data_aatid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_seo_data_aatid ON labpkl_v1.labpkl_v1_seo_data USING btree (asset_id, asset_type_id);


--
