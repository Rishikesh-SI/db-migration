-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_seo_data_aatid
-- Type: INDEX

-- Name: ix_kxp_seo_data_aatid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_seo_data_aatid ON labstlz.labstlz_seo_data USING btree (asset_id, asset_type_id);


--
