-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_ad_ad_type
-- Type: INDEX

-- Name: ix_pcm_ad_ad_type; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_ad_ad_type ON pcm.pcm_ad USING btree (ad_type);


--
