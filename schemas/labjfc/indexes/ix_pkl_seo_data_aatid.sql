-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_seo_data_aatid
-- Type: INDEX

-- Name: ix_pkl_seo_data_aatid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_seo_data_aatid ON labjfc.labjfc_seo_data USING btree (asset_id, asset_type_id);


--
