-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_seo_data_aatid
-- Type: INDEX

-- Name: ix_scup_seo_data_aatid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_seo_data_aatid ON u17wc.u17wc_seo_data USING btree (asset_id, asset_type_id);


--
