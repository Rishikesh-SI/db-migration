-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: ix_ttmum_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttmum_seo_data_aatid; Type: INDEX; Schema: labgsoc; Owner: -
--

CREATE INDEX ix_ttmum_seo_data_aatid ON labgsoc.labgsoc_seo_data USING btree (asset_id, asset_type_id);


--
