-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON ttmum.ttmum_ad USING btree (ad_type);


--
