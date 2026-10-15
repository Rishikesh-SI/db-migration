-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_seo_data_aatid
-- Type: INDEX

-- Name: ix_stn_seo_data_aatid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_seo_data_aatid ON stn.stn_seo_data USING btree (asset_id, asset_type_id);


--
