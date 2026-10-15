-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_seo_data_aatid
-- Type: INDEX

-- Name: ix_seo_data_aatid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_seo_data_aatid ON tfa.tfa_seo_data USING btree (asset_id, asset_type_id);


--
