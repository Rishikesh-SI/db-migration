-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_seo_data_aatid
-- Type: INDEX

-- Name: ix_ttgl_seo_data_aatid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_seo_data_aatid ON ttgl.ttgl_seo_data USING btree (asset_id, asset_type_id);


--
