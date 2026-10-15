-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_seo_data_aatid
-- Type: INDEX

-- Name: ix_ppb_seo_data_aatid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_seo_data_aatid ON ppb.ppb_seo_data USING btree (asset_id, asset_type_id);


--
