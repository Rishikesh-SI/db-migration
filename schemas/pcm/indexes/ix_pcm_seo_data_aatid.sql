-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_seo_data_aatid
-- Type: INDEX

-- Name: ix_pcm_seo_data_aatid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_seo_data_aatid ON pcm.pcm_seo_data USING btree (asset_id, asset_type_id);


--
