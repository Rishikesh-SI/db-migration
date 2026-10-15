-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_seo_data_aatid
-- Type: INDEX

-- Name: ix_mum_seo_data_aatid; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_seo_data_aatid ON dhm.dhm_seo_data USING btree (asset_id, asset_type_id);


--
