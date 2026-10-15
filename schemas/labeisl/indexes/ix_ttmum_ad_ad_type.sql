-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labeisl.labeisl_ad USING btree (ad_type);


--
