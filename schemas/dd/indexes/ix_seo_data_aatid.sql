-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_seo_data_aatid
-- Type: INDEX

-- Name: ix_seo_data_aatid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_seo_data_aatid ON dd.dd_seo_data USING btree (asset_id, asset_type_id);


--
