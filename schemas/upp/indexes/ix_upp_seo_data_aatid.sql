-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_seo_data_aatid
-- Type: INDEX

-- Name: ix_upp_seo_data_aatid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_seo_data_aatid ON upp.upp_seo_data USING btree (asset_id, asset_type_id);


--
