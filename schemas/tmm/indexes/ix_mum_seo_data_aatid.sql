-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_seo_data_aatid
-- Type: INDEX

-- Name: ix_mum_seo_data_aatid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_seo_data_aatid ON tmm.tmm_seo_data USING btree (asset_id, asset_type_id);


--
