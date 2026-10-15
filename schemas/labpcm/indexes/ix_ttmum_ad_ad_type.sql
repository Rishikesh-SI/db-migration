-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labpcm; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labpcm.labpcm_ad USING btree (ad_type);


--
