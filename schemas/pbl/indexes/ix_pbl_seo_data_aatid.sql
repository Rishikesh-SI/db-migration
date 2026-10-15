-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_seo_data_aatid
-- Type: INDEX

-- Name: ix_pbl_seo_data_aatid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_seo_data_aatid ON pbl.pbl_seo_data USING btree (asset_id, asset_type_id);


--
