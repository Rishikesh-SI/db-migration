-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_seo_data_aatid
-- Type: INDEX

-- Name: ix_mum_seo_data_aatid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_seo_data_aatid ON tmmimg_upd.tmmimg_upd_seo_data USING btree (asset_id, asset_type_id);


--
