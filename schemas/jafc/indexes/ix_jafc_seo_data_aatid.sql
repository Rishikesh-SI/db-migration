-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_seo_data_aatid
-- Type: INDEX

-- Name: ix_jafc_seo_data_aatid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_seo_data_aatid ON jafc.jafc_seo_data USING btree (asset_id, asset_type_id);


--
